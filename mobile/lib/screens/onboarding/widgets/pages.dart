import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'onboarding_radio_options.dart';

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
            backgroundImage:
                CachedNetworkImageProvider("https://github.com/nabildroid.png"),
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
