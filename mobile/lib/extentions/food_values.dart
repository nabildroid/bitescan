import 'package:bitescan/models/food.dart';
import 'package:flutter/material.dart';

extension NutritionDisplay on Nutrition {
  MapEntry<String, Color> get display {
    switch (this) {
      case Nutrition.caffeine:
        return MapEntry(
            "caffeine", Colors.brown.shade400); // Slightly darker for contrast

      case Nutrition.protein:
        return MapEntry(
            "protein",
            Colors.lightGreen
                .shade600); // Green is energizing and contrasts purple well

      case Nutrition.fats:
        return MapEntry("fats",
            Colors.amber.shade400); // Amber is warm and visible on purple

      case Nutrition.saturatedFats:
        return MapEntry(
            "saturatedFats", Colors.deepOrange.shade300); // Bold for emphasis

      case Nutrition.monounsaturatedFats:
        return MapEntry("monounsaturatedFats",
            Colors.orangeAccent.shade200); // Complementary tone

      case Nutrition.polyunsaturatedFats:
        return MapEntry(
            "polyunsaturatedFats", Colors.teal.shade400); // Cool and visible

      case Nutrition.transFats:
        return MapEntry(
            "transFats", Colors.red.shade300); // Red signifies caution

      case Nutrition.sugars:
        return MapEntry(
            "sugars", Colors.pinkAccent.shade200); // Vibrant and energetic

      case Nutrition.fiber:
        return MapEntry(
            "fiber", Colors.green.shade700); // Dark green for earthiness

      case Nutrition.starch:
        return MapEntry("starch", Colors.cyan.shade500); // Fresh and clean

      case Nutrition.carbohydrates:
        return MapEntry(
            "carbohydrates", Colors.yellow.shade700); // Bright and noticeable

      case Nutrition.cholesterol:
        return MapEntry(
            "cholesterol", Colors.redAccent.shade100); // Light caution tone

      case Nutrition.omega3:
        return MapEntry(
            "omega3", Colors.blueAccent.shade700); // Rich oceanic blue

      case Nutrition.omega6:
        return MapEntry(
            "omega6", Colors.cyanAccent.shade400); // Vibrant aqua tone

      case Nutrition.antioxidants:
        return MapEntry("antioxidants",
            Colors.purpleAccent.shade200); // Matches theme but distinguishable

      case Nutrition.aminoAcids:
        return MapEntry(
            "aminoAcids", Colors.indigo.shade400); // Subtle yet contrasting

      case Nutrition.creatine:
        return MapEntry(
            "creatine", Colors.blueAccent.shade100); // Light and clean

      case Nutrition.phytosterols:
        return MapEntry(
            "phytosterols", Colors.greenAccent.shade400); // Natural and vibrant
    }
  }
}

extension NutritionId on Nutrition {
  String get id {
    switch (this) {
      case Nutrition.protein:
        return 'protein';
      case Nutrition.fats:
        return 'fats';
      case Nutrition.saturatedFats:
        return 'saturatedFats';
      case Nutrition.monounsaturatedFats:
        return 'monounsaturatedFats';
      case Nutrition.polyunsaturatedFats:
        return 'polyunsaturatedFats';
      case Nutrition.transFats:
        return 'transFats';
      case Nutrition.sugars:
        return 'sugars';
      case Nutrition.fiber:
        return 'fiber';
      case Nutrition.starch:
        return 'starch';
      case Nutrition.carbohydrates:
        return 'carbohydrates';
      case Nutrition.cholesterol:
        return 'cholesterol';
      case Nutrition.omega3:
        return 'omega3';
      case Nutrition.omega6:
        return 'omega6';
      case Nutrition.antioxidants:
        return 'antioxidants';
      case Nutrition.aminoAcids:
        return 'aminoAcids';
      case Nutrition.caffeine:
        return 'caffeine';
      case Nutrition.creatine:
        return 'creatine';
      case Nutrition.phytosterols:
        return 'phytosterols';
    }
  }

  static Map<String, T> serialize<T>(Map<Nutrition, T> data) {
    final list = List<MapEntry<Nutrition, T>>.from(data.entries);

    return Map.fromEntries(list.map((e) => MapEntry(e.key.id, e.value)));
  }

  static Map<Nutrition, T> deserialize<T>(Map<String, T> data) {
    final list = List<MapEntry<String, T>>.from(data.entries);

    return Map.fromEntries(list.map((e) {
      final t = Nutrition.values.firstWhere((test) => test.id == e.key);
      return MapEntry(t, e.value);
    }));
  }
}

extension VetaminsId on Vetamins {
  String get id {
    switch (this) {
      case Vetamins.a:
        return 'a';
      case Vetamins.b1:
        return 'b1';
      case Vetamins.b2:
        return 'b2';
      case Vetamins.b3:
        return 'b3';
      case Vetamins.b5:
        return 'b5';
      case Vetamins.b6:
        return 'b6';
      case Vetamins.b7:
        return 'b7';
      case Vetamins.b9:
        return 'b9';
      case Vetamins.b12:
        return 'b12';
      case Vetamins.c:
        return 'c';
      case Vetamins.d:
        return 'd';
      case Vetamins.e:
        return 'e';
      case Vetamins.k:
        return 'k';
    }
  }

  static Map<String, T> serialize<T>(Map<Vetamins, T> data) {
    final list = List<MapEntry<Vetamins, T>>.from(data.entries);

    return Map.fromEntries(list.map((e) => MapEntry(e.key.id, e.value)));
  }

  static Map<Vetamins, T> deserialize<T>(Map<String, T> data) {
    final list = List<MapEntry<String, T>>.from(data.entries);

    return Map.fromEntries(list.map((e) {
      final t = Vetamins.values.firstWhere((test) => test.id == e.key);
      return MapEntry(t, e.value);
    }));
  }
}

extension MineralsId on Minerals {
  String get id {
    switch (this) {
      case Minerals.magnesium:
        return 'magnesium';
      case Minerals.calcium:
        return 'calcium';
      case Minerals.phosphorus:
        return 'phosphorus';
      case Minerals.potassium:
        return 'potassium';
      case Minerals.sodium:
        return 'sodium';
      case Minerals.iron:
        return 'iron';
      case Minerals.zinc:
        return 'zinc';
      case Minerals.selenium:
        return 'selenium';
      case Minerals.copper:
        return 'copper';
      case Minerals.manganese:
        return 'manganese';
      case Minerals.iodine:
        return 'iodine';
      case Minerals.chromium:
        return 'chromium';
      case Minerals.fluoride:
        return 'fluoride';
      case Minerals.molybdenum:
        return 'molybdenum';
    }
  }

  static Map<String, T> serialize<T>(Map<Minerals, T> data) {
    final list = List<MapEntry<Minerals, T>>.from(data.entries);

    return Map.fromEntries(list.map((e) => MapEntry(e.key.id, e.value)));
  }

  static Map<Minerals, T> deserialize<T>(Map<String, T> data) {
    final list = List<MapEntry<String, T>>.from(data.entries);

    return Map.fromEntries(list.map((e) {
      final t = Minerals.values.firstWhere((test) => test.id == e.key);
      return MapEntry(t, e.value);
    }));
  }
}
