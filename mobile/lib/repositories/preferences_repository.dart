import 'dart:async';
import 'dart:ffi';

import 'package:bitescan/extentions/loggable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [PreferenceRepository] is for storing user preferences.
class PreferenceRepository with Loggable {
  PreferenceRepository({
    Future<SharedPreferences>? prefs,
  }) : _prefs = prefs ?? SharedPreferences.getInstance();

  static const globalPrefix = "1";

  final Future<SharedPreferences> _prefs;

  Future<bool?> getBool(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getBool(globalPrefix + key),
      );

  Future<String?> getString(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getString(globalPrefix + key),
      );

  Future<int?> getInt(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getInt(globalPrefix + key),
      );
  Future<double?> getDouble(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getDouble(globalPrefix + key),
      );

  //ignore: avoid_positional_boolean_parameters
  void setBool(String key, bool val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setBool(globalPrefix + key, val),
      );
  void setInt(String key, int val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setInt(globalPrefix + key, val),
      );
  void setDouble(String key, double val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setDouble(globalPrefix + key, val),
      );

  void setString(String key, String val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setString(globalPrefix + key, val),
      );
  void remove(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.remove(globalPrefix + key),
      );

  Future<bool> get isFirstTime async {
    return (await getBool("isFirstTime")) ?? true;
  }

  @override
  String get logIdentifier => '[PreferenceRepository]';
}
