import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/models/goal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';

import 'config/custom_router.dart';
import 'config/locator.dart';

abstract class Storage {
  static final goalId = ValueNotifier("");
  static final goal = ValueNotifier<Goal?>(null);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocator();
  await initializeDateFormatting(Platform.localeName);

  EquatableConfig.stringify = true;

  FlutterError.onError = (FlutterErrorDetails details) {
    locator.get<Logger>().e(
          details.summary,
          error: details.exceptionAsString(),
          stackTrace: details.stack,
        );
  };

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(BitescanApp(
    savedThemeMode: savedThemeMode,
  ));
}

class BitescanApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const BitescanApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OnboardingCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => DataCubit()..init(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
        title: 'BitScan',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
