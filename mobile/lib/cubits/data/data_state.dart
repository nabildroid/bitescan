import 'package:bitescan/models/food.dart';
import 'package:equatable/equatable.dart';

import '../../models/goal.dart';

class DataState extends Equatable {
  // todo add information about last checking
  final List<Food> foods;
  final List<Goal> goals;

  final bool isOffline;

  const DataState({
    required this.foods,
    required this.goals,
    required this.isOffline,
  });

  const DataState.inital()
      : foods = const [],
        isOffline = true,
        goals = const [];

  DataState copyWith({
    List<Food>? foods,
    List<Goal>? goals,
    bool? isOffline,
  }) {
    return DataState(
      foods: foods ?? this.foods,
      goals: goals ?? this.goals,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [goals, foods, isOffline];
}
