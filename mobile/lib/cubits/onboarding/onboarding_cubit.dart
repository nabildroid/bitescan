import 'package:bitescan/config/locator.dart';
import 'package:bitescan/cubits/onboarding/onboarding_state.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/repositories/preferences_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnboardingCubit extends HydratedCubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState.inital());

  void init() {}

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
    emit(state.copyWith(goal: goal));
  }

  List<Goal> getSuggestion(List<Goal> goals) {
    return goals.where((goal) {
      if (state.gender != "female" && goal.name == "weight") return false;
      return true;
    }).toList();
  }

  @override
  void onChange(change) {
    super.onChange(change);

    if (state.goal == null) return;

    // print(a);
  }

  @override
  OnboardingState? fromJson(Map<String, dynamic> json) {
    return state.copyWith(
      name: json["name"],
      ageGroup: json["ageGroup"],
      gender: json["gender"],
      goal: json["goal"] != null ? Goal.fromJson(json["goal"]) : null,
    );
  }

  @override
  Map<String, dynamic>? toJson(OnboardingState state) {
    if (state.goal == null) {
      return null;
    }

    locator.get<PreferenceRepository>().firstTime(val: false);

    return {
      "name": state.name,
      "gender": state.gender,
      "ageGroup": state.ageGroup,
      "goal": state.goal!.toJson(),
    };
  }
}
