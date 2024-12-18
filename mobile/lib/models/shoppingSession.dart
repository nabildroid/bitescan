import 'dart:math';

import 'package:equatable/equatable.dart';

class PurchaseDecision extends Equatable {
  final String code;
  final bool isPurchased;

  const PurchaseDecision(this.code, {required this.isPurchased});

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "isPurchased": isPurchased,
    };
  }

  factory PurchaseDecision.fromJson(Map data) {
    return PurchaseDecision(data["code"], isPurchased: data["isPurchased"]);
  }

  @override
  List<Object?> get props => [code, isPurchased];
}

// todo consider adding a goal;
class Shoppingsession extends Equatable {
  final String id;

  final List<String> visitedFoodCodes;
  final List<PurchaseDecision>? confirmedFoodCodes;
  final Duration duration;
  final DateTime createdAt;

  const Shoppingsession({
    required this.id,
    required this.visitedFoodCodes,
    this.confirmedFoodCodes,
    required this.duration,
    required this.createdAt,
  });

  Shoppingsession.create()
      : id = (Random().nextInt(100000000) + 100000000).toString(),
        createdAt = DateTime.now(),
        visitedFoodCodes = [],
        confirmedFoodCodes = null,
        duration = Duration(seconds: 0);

  Shoppingsession copyWith({
    String? id,
    List<String>? visitedFoodCodes,
    List<PurchaseDecision>? confirmedFoodCodes,
    Duration? duration,
    DateTime? createdAt,
  }) {
    return Shoppingsession(
      id: id ?? this.id,
      visitedFoodCodes: visitedFoodCodes ?? this.visitedFoodCodes,
      confirmedFoodCodes: confirmedFoodCodes ?? this.confirmedFoodCodes,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  addFood(String code) {
    return copyWith(visitedFoodCodes: [...visitedFoodCodes, code]);
  }

  Shoppingsession decide(PurchaseDecision? decision) {
    if (decision == null) {
      return copyWith(visitedFoodCodes: []);
    } else {
      // todo ensure no dupilication
      return copyWith(
          confirmedFoodCodes: [...(confirmedFoodCodes ?? []), decision]);
    }
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
      "confirmedFoodCodes": confirmedFoodCodes?.map((e) => e.toJson()).toList(),
    };
  }

  factory Shoppingsession.fromJson(Map<String, dynamic> data) {
    return Shoppingsession(
      createdAt: DateTime.parse(data["createdAt"]),
      duration: Duration(milliseconds: data["duration"]),
      id: data["id"],
      visitedFoodCodes: List<String>.from(data["visitedFoodCodes"]),
      confirmedFoodCodes: data["confirmedFoodCodes"] != null
          ? List<Map>.from(data["confirmedFoodCodes"])
              .map((e) => PurchaseDecision.fromJson(e))
              .toList()
          : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, duration, visitedFoodCodes, confirmedFoodCodes];
}
