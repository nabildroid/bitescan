import 'dart:convert';

import 'package:bitescan/config/locator.dart';
import 'package:bitescan/cubits/scanning/scanning_state.dart';
import 'package:bitescan/extentions/loggable.dart';
import 'package:bitescan/models/shoppingSession.dart';
import 'package:bitescan/repositories/preferences_repository.dart';
import 'package:bitescan/services/local_notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanningCubit extends Cubit<ScanningState> with Loggable {
  final PreferenceRepository _prefs;

  ScanningCubit({PreferenceRepository? preferenceRepository})
      : _prefs = preferenceRepository ?? locator.get(),
        super(ScanningState());

  void init() async {
    await loadFromCache();
  }

  confirmFood({
    required String sessionId,
    required PurchaseDecision decision,
  }) {
    final newSessionReview = state.shoppings.map((e) {
      if (e.id == sessionId) return e.decide(decision);
      return e;
    }).toList();

    emit(state.copyWith(shoppings: newSessionReview.toSet()));
  }

  startShoppingSession() {
    if (state.session == null) {
      emit(state.copyWith(session: Shoppingsession.create()));
      return;
    }

    if (state.session!.isOld) {
      emit(state.copyWith(
        shoppings: {...state.shoppings, state.session!},
        session: Shoppingsession.create(),
      ));
      return;
    }
  }

  dispatchScannedFood(String code) {
    logInfo("Scanned " + code);
    _addFoodToSession(code);
  }

  dispatchViewedFood(String code) {
    logInfo("Viewed " + code);
    _addFoodToSession(code);
  }

  void _addFoodToSession(String code) async {
    emit(state.copyWith(session: state.session!.addFood(code)));

    final isSessionMature = state.session!.visitedFoodCodes.length == 2;

    if (isSessionMature) {
      locator
          .get<LocalNotificationService>()
          .scheduleSessionConfrirmation(sessionId: state.session!.id);

      logDebug("going to prepare Notification For Confirmation Session");
    }
  }

  dispatchShoppingSecond() {
    emit(state.copyWith(session: state.session!.nextSecond()));
    // logInfo("anothe second of shoppinig" + DateTime.now().toString());
  }

  Future<void> loadFromCache() async {
    final d1 =
        jsonDecode(((await _prefs.getString("Scanning_shoppings"))) ?? "[]")
            as List<dynamic>;

    final shoppingSessions =
        d1.map((e) => Shoppingsession.fromJson(e)).toList();

    final d2 =
        jsonDecode(((await _prefs.getString("Scanning_session"))) ?? "null");

    final Shoppingsession? session;
    if (d2 != null) {
      session = Shoppingsession.fromJson(d2);

      if (!session.isOld) {
        emit(state.copyWith(session: Shoppingsession.fromJson(d2)));
      } else {
        shoppingSessions.add(session);
      }
    }
    emit(state.copyWith(shoppings: Set.from(shoppingSessions)));
  }

  @override
  void onChange(change) {
    super.onChange(change);

    if (change.nextState.session == null) {
      _prefs.remove("Scanning_session");
    } else {
      _prefs.setString(
          "Scanning_session", jsonEncode(change.nextState.session!.toJson()));
    }

    _prefs.setString(
        "Scanning_shoppings",
        jsonEncode(
          change.nextState.shoppings.map((e) => e.toJson()).toList(),
        ));
  }

  @override
  String get logIdentifier => "Scanning Cubit";
}

extension on Shoppingsession {
  bool get isOld {
    const timeout = Duration(seconds: 10);

    return createdAt.add(timeout).compareTo(DateTime.now()) < 0;
  }
}
