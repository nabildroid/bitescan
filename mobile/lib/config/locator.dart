import 'package:bitescan/repositories/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerSingleton(Logger());
  locator.registerSingleton(PreferenceRepository());

  locator.registerSingleton(RouteObserver<ModalRoute<dynamic>>());
}
