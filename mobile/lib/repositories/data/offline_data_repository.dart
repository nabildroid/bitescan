// ignore_for_file: library_private_types_in_public_api

import 'package:bitescan/config/locator.dart';
import 'package:bitescan/extentions/loggable.dart';
import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

typedef _StoreType = StoreRef<String, Map<String, Object?>>;

class OfflineDataRepository with Loggable {
  final _StoreType _foodsStore;
  final _StoreType _goalsStore;

  final Database _db;

  OfflineDataRepository({
    _StoreType? foodsStore,
    _StoreType? goalsStore,
    Database? db,
  })  : _foodsStore = foodsStore ?? stringMapStoreFactory.store("foods"),
        _goalsStore = goalsStore ?? stringMapStoreFactory.store("goals"),
        _db = db ?? locator.get();

  Future<List<Food>> getCachedFoods() async {
    final query = await _foodsStore.find(_db);

    if (query.isEmpty) {
      // load from a file
      return [];
    }

    return query.map((e) => Food.fromJson(e.value)).toList();
  }

  Future<void> cacheFoods(List<Food> foods) async {
    try {
      await _foodsStore.drop(_db);
      await _db.transaction((txn) async {
        for (final food in foods) {
          await _foodsStore.record(food.id).add(txn, food.toJson());
        }
      });
    } catch (e) {
      logError(e);
    }
  }

  Future<void> cacheGoals(List<Goal> goal) async {
    try {
      await _goalsStore.drop(_db);
      await _db.transaction((txn) async {
        for (final goal in goal) {
          await _goalsStore.record(goal.id).add(txn, goal.toJson());
        }
      });
    } catch (e) {
      logError(e);
    }
  }

  Future<List<Goal>> getCachedGoals() async {
    final query = await _goalsStore.find(_db);

    if (query.isEmpty) {
      // load from a file
      return [];
    }

    return query.map((e) => Goal.fromJson(e.value)).toList();
  }

  @override
  // todo make sure you consistnly use the same format
  String get logIdentifier => "OfflineDataRepository";
}
