import 'dart:math';

import 'package:equatable/equatable.dart';

// todo consider adding a goal;
class Shoppingsession extends Equatable {
  final String id;

  final List<String> visitedFoodCodes;
  final Duration duration;
  final DateTime createdAt;

  const Shoppingsession({
    required this.id,
    required this.visitedFoodCodes,
    required this.duration,
    required this.createdAt,
  });

  Shoppingsession.create()
      : id = (Random().nextInt(100000000) + 100000000).toString(),
        createdAt = DateTime.now(),
        visitedFoodCodes = [],
        duration = Duration(seconds: 0);

  copyWith({
    String? id,
    List<String>? visitedFoodCodes,
    Duration? duration,
    DateTime? createdAt,
  }) {
    return Shoppingsession(
      id: id ?? this.id,
      visitedFoodCodes: visitedFoodCodes ?? this.visitedFoodCodes,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  addFood(String code) {
    return copyWith(visitedFoodCodes: [...visitedFoodCodes, code]);
  }

  nextSecond() {
    return copyWith(duration: duration + Duration(seconds: 1));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "duration": duration.inMilliseconds,
      "createdAt": createdAt.toIso8601String(),
      "visitedFoodCodes": visitedFoodCodes,
    };
  }

  factory Shoppingsession.fromJson(Map<String, dynamic> data) {
    return Shoppingsession(
        createdAt: DateTime.parse(data["createdAt"]),
        duration: Duration(milliseconds: data["duration"]),
        id: data["id"],
        visitedFoodCodes: List<String>.from(data["visitedFoodCodes"]));
  }

  @override
  List<Object?> get props => [id, duration, visitedFoodCodes];
}
