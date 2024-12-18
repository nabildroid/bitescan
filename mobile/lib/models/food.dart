import 'dart:math';

import 'package:bitescan/extentions/food_values.dart';

enum Nutrition {
  protein,
  fats,
  saturatedFats,
  monounsaturatedFats,
  polyunsaturatedFats,
  transFats,
  sugars,
  fiber,
  starch,
  carbohydrates,
  cholesterol,
  omega3,
  omega6,
  antioxidants,
  aminoAcids,
  caffeine,
  creatine,
  phytosterols,
}

enum Vetamins {
  a,
  b1,
  b2,
  b3,
  b5,
  b6,
  b7,
  b9,
  b12,
  c,
  d,
  e,
  k,
}

enum Minerals {
  magnesium,
  calcium,
  phosphorus,
  potassium,
  sodium,
  iron,
  zinc,
  selenium,
  copper,
  manganese,
  iodine,
  chromium,
  fluoride,
  molybdenum,
}

class Food {
  final String id;
  String code;
  final String name;
  final String image;
  final double quantity;

  final String category;
  final String subcategory;
  final double avgDialyConsumption;
  final double calories;
  final Map<Nutrition, double> nutritions;
  final Map<Minerals, double> minerals;
  final Map<Vetamins, double> vitamins;

  Food({
    required this.id,
    required this.code,
    required this.name,
    required this.image,
    required this.calories,
    required this.category,
    required this.subcategory,
    required this.nutritions,
    required this.minerals,
    required this.quantity,
    required this.avgDialyConsumption,
    required this.vitamins,
  });

  Map<String, dynamic> toJson() {
    return {
      "nutritions": NutritionId.serialize(nutritions),
      "vitamins": VetaminsId.serialize(vitamins),
      "minerals": MineralsId.serialize(minerals),
      "code": code,
      "id": id,
      "name": name,
      "image": image,
      "avgDialyConsumption": avgDialyConsumption,
      "quantity": quantity,
      "calories": calories,
      "category": category,
      "subcategory": subcategory,
    };
  }

  static Food fromJson(Map<String, dynamic> data) {
    return Food(
      nutritions:
          NutritionId.deserialize(Map<String, double>.from(data["nutritions"])),
      vitamins:
          VetaminsId.deserialize(Map<String, double>.from(data["vitamins"])),
      minerals:
          MineralsId.deserialize(Map<String, double>.from(data["minerals"])),
      avgDialyConsumption: data["avgDialyConsumption"],
      id: data["id"],
      name: data["name"],
      calories: data["calories"],
      subcategory: data["subcategory"],
      image: data["image"],
      quantity: data["quantity"],
      category: data["category"],
      code: data["code"],
    );
  }

  @override
  List<Object?> get props => [id];
}
