import 'package:bitescan/models/goal.dart';
import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final String name;
  final int ageGroup;
  final String gender;

  final Goal? goal;

  const OnboardingState({
    required this.name,
    required this.ageGroup,
    required this.gender,
    required this.goal,
  });

  const OnboardingState.inital()
      : goal = null,
        ageGroup = 0,
        gender = "test",
        name = "";

  OnboardingState copyWith({
    String? name,
    int? ageGroup,
    String? gender,
    Goal? goal,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
    );
  }

  @override
  List<Object?> get props => [
        goal?.id,
        name,
        ageGroup,
        gender,
      ];
}
