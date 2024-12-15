import 'package:bitescan/cubits/onboarding/onboarding_state.dart';
import 'package:bitescan/models/goal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState.inital());

  void setAgeGroup(int ageGroup) {
    emit(state.copyWith(ageGroup: ageGroup));
  }

  void setGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void setName(String name) {
    print("setting the name");
    emit(state.copyWith(name: name));
  }

  void setGoal(Goal goal) {
    emit(state.copyWith(initalGoal: goal));
  }

  List<Goal> getSuggestion(List<Goal> goals) {
    return goals.where((goal) {
      if (state.gender != "female" && goal.name == "weight") return false;
      return true;
    }).toList();
  }
}
