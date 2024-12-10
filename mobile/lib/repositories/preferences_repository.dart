import 'dart:async';

import 'package:bitescan/extentions/loggable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [PreferenceRepository] is for storing user preferences.
class PreferenceRepository with Loggable {
  PreferenceRepository({
    Future<SharedPreferences>? prefs,
  }) : _prefs = prefs ?? SharedPreferences.getInstance();

  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _blocklistKey = 'blocklist';
  static const String _filterKeywordsKey = 'filterKeywords';
  static const String _unreadCommentsIdsKey = 'unreadCommentsIds';
  static const String _lastReadStoryIdKey = 'lastReadStoryId';

  final Future<SharedPreferences> _prefs;

  Future<bool> get loggedIn async => await username != null;

  Future<String?> get username async => (await _prefs).getString(_usernameKey);

  Future<String?> get password async => (await _prefs).getString(_passwordKey);

  Future<bool?> getBool(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getBool(key),
      );

  Future<int?> getInt(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getInt(key),
      );

  Future<double?> getDouble(String key) => _prefs.then(
        (SharedPreferences prefs) => prefs.getDouble(key),
      );

  //ignore: avoid_positional_boolean_parameters
  void setBool(String key, bool val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setBool(key, val),
      );

  void setInt(String key, int val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setInt(key, val),
      );

  void setDouble(String key, double val) => _prefs.then(
        (SharedPreferences prefs) => prefs.setDouble(key, val),
      );

  Future<bool> hasPushed(int commentId) async =>
      _prefs.then((SharedPreferences prefs) {
        final bool? val = prefs.getBool(_getPushNotificationKey(commentId));

        if (val == null) return false;

        return true;
      });

  Future<void> setAuth({
    required String username,
    required String password,
  }) async {
    try {
      await (await _prefs).setString(_usernameKey, username);
      await (await _prefs).setString(_passwordKey, password);
    } catch (_) {
      try {} catch (e) {
        logError(e);
      }

      rethrow;
    }
  }

  Future<void> removeAuth() async {}

  static String _getFavKey(String username) => 'fav_$username';

  //#endregion

  //#region vote

  Future<bool?> vote({required int submittedTo, required String from}) async {
    final SharedPreferences prefs = await _prefs;
    final String key = _getVoteKey(from, submittedTo);
    final bool? vote = prefs.getBool(key);
    return vote;
  }

  Future<void> addVote({
    required String username,
    required int id,
    required bool vote,
  }) async {
    final SharedPreferences prefs = await _prefs;
    final String key = _getVoteKey(username, id);
    await prefs.setBool(key, vote);
  }

  Future<void> removeVote({
    required String username,
    required int id,
  }) async {
    final SharedPreferences prefs = await _prefs;
    final String key = _getVoteKey(username, id);
    await prefs.remove(key);
  }

  String _getVoteKey(String username, int id) => 'vote_$username-$id';

  //#endregion

  //#region blocklist

  Future<List<String>> get blocklist async => _prefs.then(
        (SharedPreferences prefs) =>
            prefs.getStringList(_blocklistKey) ?? <String>[],
      );

  Future<void> updateBlocklist(List<String> usernames) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(_blocklistKey, usernames);
  }

  //#endregion

  //#region filter

  Future<List<String>> get filterKeywords async => _prefs.then(
        (SharedPreferences prefs) =>
            prefs.getStringList(_filterKeywordsKey) ?? <String>[],
      );

  Future<void> updateFilterKeywords(List<String> keywords) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(_filterKeywordsKey, keywords);
  }

  //#endregion

  //#region pins

  //#endregion

  //#region unread comment ids

  Future<List<int>> get unreadCommentsIds async => _prefs.then(
        (SharedPreferences prefs) =>
            prefs
                .getStringList(_unreadCommentsIdsKey)
                ?.map(int.parse)
                .toList() ??
            <int>[],
      );

  Future<void> updateUnreadCommentsIds(List<int> ids) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(
      _unreadCommentsIdsKey,
      ids.map((int e) => e.toString()).toList(),
    );
  }

  //#endregion

  //#region reminder

  Future<int?> get lastReadStoryId async =>
      _prefs.then((SharedPreferences prefs) {
        final String? val = prefs.getString(_lastReadStoryIdKey);

        if (val == null) return null;

        return int.tryParse(val);
      });

  Future<void> updateLastReadStoryId(int? id) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(
      _lastReadStoryIdKey,
      id.toString(),
    );
  }

  //#endregion

  Future<void> updateHasPushed(int commentId) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(
      _getPushNotificationKey(commentId),
      true,
    );
  }

  static String _getPushNotificationKey(int commentId) => 'pushed_$commentId';

  static String _getHasReadKey(int storyId) => 'hasRead_$storyId';

  @override
  String get logIdentifier => '[PreferenceRepository]';
}
