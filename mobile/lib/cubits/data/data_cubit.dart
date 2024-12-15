import 'package:bitescan/config/locator.dart';
import 'package:bitescan/cubits/data/data_state.dart';
import 'package:bitescan/repositories/remote_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataCubit extends Cubit<DataState> {
  final RemoteDataRepository _dataRepository;
  DataCubit({RemoteDataRepository? dataRepository})
      : _dataRepository = dataRepository ?? locator.get(),
        super(DataState.inital());

  void init() async {
    _dataRepository.getFoods().then((val) => {
          emit(state.copyWith(foods: val)),
        });
    _dataRepository.getGoals().then((val) => {
          emit(state.copyWith(goals: val)),
        });
  }

  void setName(String name) {}
}
