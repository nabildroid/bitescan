import 'package:bitescan/config/locator.dart';
import 'package:bitescan/cubits/data/data_state.dart';
import 'package:bitescan/extentions/loggable.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/repositories/data/offline_data_repository.dart';
import 'package:bitescan/repositories/data/remote_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DataCubit extends Cubit<DataState> with Loggable {
  final RemoteDataRepository _repo;
  final OfflineDataRepository _offlineRepo;

  DataCubit({
    RemoteDataRepository? dataRepository,
    OfflineDataRepository? offlineDataRepository,
  })  : _repo = dataRepository ?? locator.get(),
        _offlineRepo = offlineDataRepository ?? locator.get(),
        super(DataState.inital());

  void init() async {
    await offlineFirstLoad();

    Connectivity().onConnectivityChanged.listen((status) {
      logInfo('network status: $status');
      if (status.contains(ConnectivityResult.none)) {
        logInfo('no network connection, entering offline mode.');
        emit(state.copyWith(isOffline: true));
      }
      emit(state.copyWith(isOffline: false));
    });
  }

  Future<void> offlineFirstLoad() async {
    final d1 = _offlineRepo.getCachedFoods().then((data) {
      emit(state.copyWith(foods: data));
    });

    final d2 = _offlineRepo.getCachedGoals().then((data) {
      emit(state.copyWith(goals: data));
    });

    await Future.value([d1, d2]);
  }

  Future<void> remoteLoading() async {
    final d1 = _repo.getFoods().then((data) {
      emit(state.copyWith(foods: data));
      return _offlineRepo.cacheFoods(
        diffFoodLists(old: state.foods, fresh: data),
      );
    }).catchError((onError) {
      logError("unable to load Foods from remote", error: onError);
    });

    final d2 = _repo.getGoals().then((data) {
      emit(state.copyWith(goals: data));

      return _offlineRepo.cacheGoals(
        diffGoalLists(old: state.goals, fresh: data),
      );
    }).catchError((onError) {
      logError("unable to load Goals from remote", error: onError);
    });

    await Future.value([d1, d2]);
  }

  @override
  void onChange(Change<DataState> change) {
    super.onChange(change);

    if (change.currentState.isOffline && !change.nextState.isOffline) {
      remoteLoading();
    }
  }

  void setName(String name) {}

  @override
  String get logIdentifier => "DataCubit";
}

List<Food> diffFoodLists({required List<Food> old, required List<Food> fresh}) {
  if (fresh.isEmpty) return old;
  return fresh;
}

List<Goal> diffGoalLists({required List<Goal> old, required List<Goal> fresh}) {
  if (fresh.isEmpty) return old;
  return fresh;
}
