import 'package:bitescan/models/goal.dart';
import 'package:bitescan/screens/home_screen.dart';
import 'package:bitescan/screens/onboarding1.dart';
import 'package:bitescan/screens/onboarding_flow.dart';
import 'package:flutter/material.dart';

abstract class Storage {
  static final goalId = ValueNotifier("");
  static final goal = ValueNotifier<Goal?>(null);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
        useMaterial3: true,
      ),
      home: OnboardingFlow(),
      debugShowCheckedModeBanner: false,
    );
  }
}
