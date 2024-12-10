import 'package:bitescan/main.dart';
import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/home_screen.dart';
import 'package:bitescan/screens/scan_test.dart';
import 'package:bitescan/widgets/onboarding_radio_options.dart';
import 'package:flutter/material.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
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

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (c) {
                    return HomeScreen(firstTime: true);
                  }),
                );
              }),
            ]),
      ),
    );
  }
}

class AgeGroupPage extends StatelessWidget {
  final VoidCallback next;
  const AgeGroupPage({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28),
          Text(
            "Finding your Goal!",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: 16),
          Text(
            "How Old Are You?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 16),
          OnboardingRadioOptions<int>(
            next: (val) {
              print((val as int).remainder(15));

              next();
            },
            options: const [
              MapEntry(MapEntry("30 - 60", "older than 30 years old"), 30),
              MapEntry(MapEntry("25 - 30", "older than 25 years old"), 25),
              MapEntry(MapEntry("18 - 25", "older than 18 years old"), 18),
              MapEntry(MapEntry("12 - 18", "yong person"), 0),
            ],
          ),
        ],
      ),
    );
  }
}

class GenderGroupPage extends StatelessWidget {
  final VoidCallback next;
  const GenderGroupPage({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28),
          Text(
            "Finding your Goal!",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: 16),
          Text(
            "Are you?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 16),
          OnboardingRadioOptions(
            next: (val) {
              print((val as String).toUpperCase());

              next();
            },
            options: const [
              MapEntry(MapEntry("Male", "goals tolerated for a man"), "man"),
              MapEntry(
                  MapEntry("Female", "goals tolerated for a women"), "female"),
            ],
          ),
        ],
      ),
    );
  }
}

class GoalGroupPage extends StatelessWidget {
  final VoidCallback next;
  const GoalGroupPage({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28),
          Text(
            "Finding your Goal!",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(height: 16),
          Text(
            "You Eat for?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 16),
          OnboardingRadioOptions(
            next: (val) {
              print((val as String).toUpperCase());

              next();
            },
            options: const [
              MapEntry(
                  MapEntry("More Energy", "goals tolerated for a man"), "man"),
              MapEntry(MapEntry("More Focus", "goals tolerated for a man"),
                  "female"),
              MapEntry(
                  MapEntry("Sport Perfomance", "goals tolerated for a man"),
                  "female"),
            ],
          ),
        ],
      ),
    );
  }
}

class AdsPage extends StatelessWidget {
  final VoidCallback next;
  const AdsPage({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28),
          CircleAvatar(
            backgroundImage: NetworkImage("https://github.com/nabildroid.png"),
            radius: 36,
          ),
          SizedBox(height: 28),
          Text(
            "Start Creating\nYour Individual\nportfolio",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 16),
          Text(
            "Scan the codebar and see the nutrition of the food and how much it aligns with your goal, if not that good pick the suggested alternatives",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black54),
          ),
          Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: double.infinity),
            child: ElevatedButton(
              onPressed: () {
                next();
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (_) => OnboardingScreen2()));
              },
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(height: 42),
        ],
      ),
    );
  }
}

class NameDialog extends StatelessWidget {
  const NameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text("Your Name"),
      icon: Icon(Icons.timer_3),
      actionsAlignment: MainAxisAlignment.center,
      content: TextField(
        autofocus: true,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Save"),
        )
      ],
    );
  }
}
