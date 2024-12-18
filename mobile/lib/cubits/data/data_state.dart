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

  DataState.inital()
      : foods = [],
        isOffline = true,
        goals = [];

  DataState copyWith({
    List<Food>? foods,
    List<Goal>? goals,
    bool? isOffline,
  }) {
    return DataState(
      foods: (foods ?? this.foods)..sort((a, b) => a.id.compareTo(b.id)),
      goals: (goals ?? this.goals)..sort((a, b) => a.id.compareTo(b.id)),
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [goals, foods, isOffline];
}
