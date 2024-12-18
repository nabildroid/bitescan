import 'package:bitescan/models/food.dart';
import 'package:equatable/equatable.dart';

import '../../models/goal.dart';

class DataState extends Equatable {
  // todo add information about last checking
  final List<Food> foods;
  final List<Goal> goals;

  const DataState({
    required this.foods,
    required this.goals,
  });

  const DataState.inital()
      : foods = const [],
        goals = const [];

  DataState copyWith({
    List<Food>? foods,
    List<Goal>? goals,
  }) {
    return DataState(
      foods: foods ?? this.foods,
      goals: goals ?? this.goals,
    );
  }

  @override
  List<Object?> get props => [goals, foods];
}
