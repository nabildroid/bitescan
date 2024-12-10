import 'package:bitescan/screens/onboarding2.dart';
import 'package:bitescan/widgets/customAppbar.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28),
            CircleAvatar(
              backgroundImage:
                  NetworkImage("https://github.com/nabildroid.png"),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OnboardingScreen2()));
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
      ),
    );
  }
}
