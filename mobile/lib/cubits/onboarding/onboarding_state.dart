import 'package:bitescan/models/goal.dart';
import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final String name;
  final int ageGroup;
  final String gender;

  final Goal? initalGoal;

  const OnboardingState({
    required this.name,
    required this.ageGroup,
    required this.gender,
    required this.initalGoal,
  });

  const OnboardingState.inital()
      : initalGoal = null,
        ageGroup = 0,
        gender = "test",
        name = "";

  OnboardingState copyWith({
    String? name,
    int? ageGroup,
    String? gender,
    Goal? initalGoal,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
      initalGoal: initalGoal ?? this.initalGoal,
    );
  }

  @override
  List<Object?> get props => [
        initalGoal?.id,
        name,
        ageGroup,
        gender,
      ];
}
