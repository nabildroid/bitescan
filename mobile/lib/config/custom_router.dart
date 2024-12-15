import 'dart:math';

import 'package:bitescan/config/paths.dart';
import 'package:bitescan/screens/home/home_screen.dart';
import 'package:bitescan/screens/onboarding/onboarding_screen.dart';
import 'package:bitescan/screens/scanning/scanning_screen.dart';
import 'package:bitescan/screens/scanning_result/scanning_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'locator.dart';

final GoRouter router = GoRouter(
  observers: [
    locator.get<RouteObserver<ModalRoute<dynamic>>>(),
  ],
  initialLocation: Paths.onboarding.landing,
  // redirect: (BuildContext context, GoRouterState state) {
  //   if (state.fullPath == null) return null;
  //   if (!state.fullPath!.contains(Paths.onboarding.landing)) {
  //     // if (Random().nextBool()) {
  //     //   return Paths.onboarding.landing;
  //     // }
  //   }
  //   return null;
  // },
  routes: [
    GoRoute(
        path: Paths.onboarding.landing, builder: (_, __) => OnboardingScreen()),
    GoRoute(
      path: Paths.home.landing,
      builder: (_, state) => HomeScreen(
        firstTime: state.uri.queryParameters.containsKey("firstTime"),
      ),
    ),
    GoRoute(path: Paths.scan.landing, builder: (_, __) => ScanningScreen()),
    GoRoute(
      path: Paths.result.landing,
      pageBuilder: (_, GoRouterState state) {
        final code = state.pathParameters["code"];
        if (code == null || code.isEmpty) {
          throw GoError("Please Provice the Food Code for the result");
        }

        return CustomTransitionPage(
          fullscreenDialog: true,
          opaque: false,
          barrierColor: Colors.black12,
          transitionsBuilder: (_, __, ___, child) => child,
          child: ScanningResultScreen(code: code),
        );
      },
    ),
  ],
);
