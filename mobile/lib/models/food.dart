import 'dart:math';

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
}
