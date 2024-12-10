import 'package:bitescan/screens/scan_test.dart';
import 'package:bitescan/widgets/customAppbar.dart';
import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
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
              "What is your\nGender?",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            RadioListTile(
              value: "hello",
              groupValue: "hello",
              onChanged: (_) {},
              title: Text("Male"),
              subtitle: Text("Fitness, Focus, Alertness ..."),
            ),
            SizedBox(height: 16),
            RadioListTile(
              value: false,
              groupValue: "hello",
              onChanged: (_) {},
              title: Text("Female"),
              subtitle: Text("Scancare, weight, Focus ..."),
            ),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: double.infinity),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ScanTest()));
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
