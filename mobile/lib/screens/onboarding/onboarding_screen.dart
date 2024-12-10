import 'package:bitescan/config/custom_router.dart';
import 'package:bitescan/config/paths.dart';
import 'package:bitescan/main.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/home/home_screen.dart';
import 'package:bitescan/screens/onboarding/widgets/onboarding_radio_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/pages.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

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
                next: () {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOutCirc);
                },
              ),
              GenderGroupPage(
                next: () {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOutCirc);
                },
              ),
              GoalGroupPage(next: () {
                final goal = goalDB.first;
                Storage.goal.value = goal;
                Storage.goalId.value = goal.id;

                context.replace(Paths.home.firstTime);
              }),
            ]),
      ),
    );
  }
}
