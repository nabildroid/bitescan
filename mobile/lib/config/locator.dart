import 'package:bitescan/repositories/data/offline_data_repository.dart';
import 'package:bitescan/repositories/preferences_repository.dart';
import 'package:bitescan/repositories/data/remote_data_repository.dart';
import 'package:bitescan/screens/shopping_confirmation/utils/utils.dart';
import 'package:bitescan/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sembast/sembast.dart';

final GetIt locator = GetIt.instance;

Future<void> setUpLocator({required Database sembastInstance}) async {
  locator.registerSingleton(Logger());
  locator.registerSingleton(sembastInstance);

  locator.registerSingleton(PreferenceRepository());
  locator.registerSingleton(RemoteDataRepository());
  locator.registerSingleton(OfflineDataRepository());

  locator.registerSingleton(LocalNotificationService(notificationEvents: [
    SessionConfirmationNotification(),
  ]));

  locator.registerSingleton(RouteObserver<ModalRoute<dynamic>>());
}
