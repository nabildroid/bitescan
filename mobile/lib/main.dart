import 'dart:io';
import 'package:bitescan/cubits/system_config/system_config_cubit.dart';
import 'package:bitescan/data_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bitescan/cubits/data/data_cubit.dart';
import 'package:bitescan/cubits/onboarding/onboarding_cubit.dart';
import 'package:bitescan/cubits/scanning/scanning_cubit.dart';
import 'package:bitescan/cubits/session_confirmation/session_confirmation_cubit.dart';
import 'package:bitescan/services/local_notification_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sembast/sembast_io.dart';

import 'package:timezone/data/latest_all.dart' as tz;

import 'config/custom_router.dart';
import 'config/locator.dart';

// For receiving payload event from local notifications.
final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

void notificationReceiver(NotificationResponse details) =>
    selectNotificationSubject.add(details.payload);

DateTime? initStarted;
void logCurrentTiming() {
  if (initStarted == null) return;
  final dur = DateTime.now().difference(initStarted!);
  locator.get<Logger>().t(
        "Init time: $dur ms",
      );

  initStarted = null;
}

void main() async {
  if (Platform.isLinux && !kReleaseMode) {
    await assetsDataGenerator();
  }

  initStarted = DateTime.now();

  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await dir.create(recursive: true);

  final db = await databaseFactoryIo.openDatabase(
    join(dir.path, 'laknabil.db'),
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: dir,
  );

  await setUpLocator(sembastInstance: db);

  await initializeDateFormatting(Platform.localeName);
  tz.initializeTimeZones();

  EquatableConfig.stringify = true;

  FlutterError.onError = (FlutterErrorDetails details) {
    locator.get<Logger>().e(
          details.summary,
          error: details.exceptionAsString(),
          stackTrace: details.stack,
        );
  };

  await locator.get<LocalNotificationService>().init();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(BitescanApp(
    savedThemeMode: savedThemeMode,
    systemConfigCubit: SystemConfigCubit(const Color(0xFF673AB7)),
  ));
}

class BitescanApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  final SystemConfigCubit systemConfigCubit;

  const BitescanApp({
    super.key,
    this.savedThemeMode,
    required this.systemConfigCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: systemConfigCubit,
        ),
        BlocProvider(
          create: (_) => DataCubit()..init(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => OnboardingCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => ScanningCubit()..init(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => SessionConfirmationCubit(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<SystemConfigCubit, SystemConfigState>(
          builder: (context, config) {
        return MaterialApp.router(
          title: 'BitScan',
          supportedLocales: const [
            Locale('fr', 'FR'),
            Locale('ar', 'DZ'),
          ],
          locale: config.locale,
          onGenerateTitle: (context) =>
              AppLocalizations.of(context)?.title ?? "bitScan",
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line

            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: config.mainColor),
            useMaterial3: true,
            textTheme: config.locale?.languageCode == "ar"
                ? GoogleFonts.notoNaskhArabicTextTheme(
                    Theme.of(context).textTheme,
                  )
                : GoogleFonts.loraTextTheme(
                    Theme.of(context).textTheme,
                  ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      }),
    );
  }
}
