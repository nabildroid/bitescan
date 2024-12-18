import 'package:bitescan/cubits/session_confirmation/session_confirmation_state.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/shoppingSession.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _Attacher = void Function(String sessionId, PurchaseDecision decision);

class SessionConfirmationCubit extends Cubit<SessionConfirmationState> {
  SessionConfirmationCubit() : super(SessionConfirmationState.inital());

  void loadSessions(List<Shoppingsession> sessions) {
    final needConfirmations =
        sessions.where((e) => e.requiresConfirmation).toList();
    emit(state.copyWith(
      sessions: needConfirmations,
    ));
  }

  void loadFoods(List<Food> foods) {
    emit(state.copyWith(foods: foods));
  }

  void startConfirming() {
    emit(state.copyWith(sessionsUnderReview: state.sessions));
  }

  void finishConfirming() {
    emit(state.copyWith(sessionsUnderReview: []));
  }

  final List<_Attacher> _attachedToConfirmation = [];
  void attachToConfirmation(_Attacher sub) {
    _attachedToConfirmation.add(sub);
  }

  void confirm(bool isPurchase) {
    final targetFood = state.queue.lastOrNull;
    if (targetFood == null) return;

    final targetSession = state.sessionsUnderReview.reversed.firstWhere(
      (e) =>
          e.confirmedFoodCodes == null ||
          !e.confirmedFoodCodes!.any((test) => test.code == targetFood.code),
    );

    final decision = PurchaseDecision(targetFood.code, isPurchased: isPurchase);

    final newSessionReview = state.sessionsUnderReview.map((e) {
      if (e.id == targetSession.id) return e.decide(decision);
      return e;
    }).toList();

    emit(
      state.copyWith(sessionsUnderReview: newSessionReview),
    );

    for (var sub in _attachedToConfirmation) {
      sub(targetSession.id, decision);
    }
  }
}

extension SessionConfirmationFilter on Shoppingsession {
  bool get requiresConfirmation {
    final isLong = duration.inSeconds > 10;
    final isRecent =
        createdAt.add(Duration(days: 2)).compareTo(DateTime.now()) > 0;

    final isHealthy = isLong && isRecent && visitedFoodCodes.length > 2;

    return isHealthy && confirmedFoodCodes == null;
  }
}
