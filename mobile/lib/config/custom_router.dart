import 'dart:math';

import 'package:bitescan/config/paths.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/main.dart';
import 'package:bitescan/repositories/preferences_repository.dart';
import 'package:bitescan/screens/home/home_screen.dart';
import 'package:bitescan/screens/onboarding/onboarding_screen.dart';
import 'package:bitescan/screens/scanning/scanning_screen.dart';
import 'package:bitescan/screens/scanning_result/scanning_result_screen.dart';
import 'package:bitescan/screens/shopping_confirmation/shopping_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'locator.dart';

final GoRouter router = GoRouter(
  observers: [
    locator.get<RouteObserver<ModalRoute<dynamic>>>(),
  ],
  initialLocation: Paths.home.landing,
  redirect: (BuildContext context, GoRouterState state) async {
    final isFirst = await locator.get<PreferenceRepository>().firstTime();

    logCurrentTiming();

    if (state.fullPath == null || isFirst == null) return null;

    if (isFirst && !state.fullPath!.contains(Paths.onboarding.landing)) {
      return Paths.onboarding.landing;
    }
    return null;
  },
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
          barrierColor: Colors.transparent,
          transitionsBuilder: (_, __, ___, child) => child,
          child: ScanningResultScreen(code: code),
        );
      },
    ),
    GoRoute(
      path: Paths.shoppingConfirmation.landing,
      pageBuilder: (_, GoRouterState state) {
        final id = state.pathParameters["id"];
        if (id == null || id.isEmpty) {
          throw GoError("Please Provice the Shooping Session id");
        }

        return CustomTransitionPage(
          fullscreenDialog: true,
          opaque: false,
          barrierColor: Colors.black45,
          transitionsBuilder: (_, __, ___, child) => child,
          child: ShoppingConfirmationScreen(id: id),
        );
      },
    ),
  ],
);
