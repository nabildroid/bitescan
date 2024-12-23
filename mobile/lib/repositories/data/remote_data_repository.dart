import 'dart:convert';

import 'package:bitescan/models/food.dart';
import 'package:bitescan/models/goal.dart';
import 'package:dio/dio.dart';

class RemoteDataRepository {
  final Dio _dio;

  RemoteDataRepository({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                  baseUrl:
                      "https://raw.githubusercontent.com/nabildroid/bitescan/main/mobile/assets/data/"),
            );

  Future<List<Food>> getFoods() async {
    final Response<dynamic> response = await _dio.get(
      "foods.json",
    );
    final String data = response.data as String? ?? '';

    final json = List<Map<String, dynamic>>.from(jsonDecode(data));

    return json.map((e) => Food.fromJson(e)).toList();
  }

  Future<List<Goal>> getGoals() async {
    final Response<dynamic> response = await _dio.get(
      "goals.json",
    );
    final String data = response.data as String? ?? '';

    final json = List<Map<String, dynamic>>.from(jsonDecode(data));

    return json.map((e) => Goal.fromJson(e)).toList();
  }
}
