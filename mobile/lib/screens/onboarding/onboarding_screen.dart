import 'package:bitescan/config/custom_router.dart';
import 'package:bitescan/config/paths.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/data/data_state.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/pages.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AnimatedBuilder(
            animation: pageController,
            builder: (context, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                    4,
                    (i) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          width: (pageController.page?.round() ?? 0) == i
                              ? 20
                              : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: (pageController.page?.round() ?? 0) == i
                                ? Colors.black87
                                : Colors.black38,
                          ),
                        ))),
              );
            }),
        centerTitle: true,
        leading: AnimatedBuilder(
            animation: pageController,
            builder: (context, _) {
              if ((pageController.page?.round() ?? 0) == 0) {
                return SizedBox.shrink();
              }

              return Center(
                child: IconButton.outlined(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    pageController.previousPage(
                        duration: Duration(milliseconds: 350),
                        curve: Curves.easeInOutCirc);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              );
            }),
      ),
      body: SizedBox.expand(
        child: PageView(
            controller: pageController,
            allowImplicitScrolling: false,
            physics: NeverScrollableScrollPhysics(),
            children: [
              AdsPage(
                next: () {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOutCirc);
                },
              ),
              AgeGroupPage(
                next: (val) {
                  context.read<OnboardingCubit>().setAgeGroup(val);
                  pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOutCirc);
                },
              ),
              GenderGroupPage(
                next: (val) {
                  context.read<OnboardingCubit>().setGender(val);
                  pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOutCirc);
                },
              ),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, onboardingState) {
                return BlocBuilder<DataCubit, DataState>(
                    builder: (context, dataState) {
                  return GoalGroupPage(
                      goals: context
                          .read<OnboardingCubit>()
                          .getSuggestion(dataState.goals),
                      next: (goal) {
                        context.read<OnboardingCubit>().setGoal(goal);
                        context.replace(Paths.home.firstTime);
                      });
                });
              }),
            ]),
      ),
    );
  }
}
