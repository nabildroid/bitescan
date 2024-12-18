import 'dart:math';

import 'package:bitescan/extentions/food_values.dart';
import 'package:equatable/equatable.dart';

import 'food.dart';

abstract class _FoodRanker {
  static double ranker1(Goal goal, Food food) {
    double nutrientScore = 0.0;
    double vitaminScore = 0.0;
    double mineralScore = 0.0;

    //Calculate Nutrient Score
    food.nutritions.forEach((nutrient, value) {
      if (goal.nutritionFactors.containsKey(nutrient)) {
        nutrientScore += value * goal.nutritionFactors[nutrient]!;
      }
    });

    // Calculate Vitamin Score
    food.vitamins.forEach((vitamin, value) {
      if (goal.vetaminsFactors.containsKey(vitamin)) {
        vitaminScore += value * goal.vetaminsFactors[vitamin]!;
      }
    });

    // Calculate Mineral Score
    food.minerals.forEach((mineral, value) {
      if (goal.mineralsFactors.containsKey(mineral)) {
        mineralScore += value * goal.mineralsFactors[mineral]!;
      }
    });

    // Calculate Calorie Score
    double calorieScore = 1 -
        (food.calories - goal.maxPositiveCalories).abs() /
            max(food.calories, goal.maxPositiveCalories);

    if (food.calories < goal.maxPositiveCalories && goal.name == "weight") {
      calorieScore += 0.2; // Bonus for low-calorie foods for weight loss goal
    }
    calorieScore = min(1, calorieScore);

    // Weights for each category (adjust as needed)
    const wn = 0.3;
    const wv = 0.3;
    const wm = 0.2;
    const wc = 0.2;

    // Final Score calculation
    return (nutrientScore * wn +
        vitaminScore * wv +
        mineralScore * wm +
        calorieScore * wc);
  }

  static double ranker2(Goal goal, Food food) {
    double gas = 0; // Goal Alignment Score

    // Nutrition factors
    for (final nutrient in goal.nutritionFactors.keys) {
      if (food.nutritions.containsKey(nutrient)) {
        gas += goal.nutritionFactors[nutrient]! *
            (food.nutritions[nutrient]! / 100); // Normalize
      }
    }

    // Vitamin Factors
    for (final vitamin in goal.vetaminsFactors.keys) {
      if (food.vitamins.containsKey(vitamin)) {
        gas += goal.vetaminsFactors[vitamin]! *
            (food.vitamins[vitamin]! / 100); // Normalize
      }
    }

    // Mineral Factors
    for (final mineral in goal.mineralsFactors.keys) {
      if (food.minerals.containsKey(mineral)) {
        gas += goal.mineralsFactors[mineral]! *
            (food.minerals[mineral]! / 100); // Normalize
      }
    }

    // Calorie Adjustment Factor
    double caf = 1;

    if (goal.name == "weight") {
      if (food.calories > goal.maxPositiveCalories) {
        caf = goal.maxPositiveCalories / food.calories;
      }
    } else {
      // for focus and energy goal
      if (food.calories > goal.maxPositiveCalories * 1.25) {
        // we punish when food exceed a limit
        caf = 1 /
            (food.calories /
                goal.maxPositiveCalories); // we inversely give calorie benefits
      } else {
        caf = min(
            1,
            food.calories /
                (goal.maxPositiveCalories *
                    0.75)); //reward up to 75% of max calories
      }
    }

    return gas * caf;
  }

  static double ranker3(Goal goal, Food food) {
    double macroScore = 0;
    double microScore = 0;
    double calorieScore = 0;

    // Macronutrient Alignment
    for (final nutrient in Nutrition.values) {
      final foodValue = food.nutritions[nutrient] ?? 0;
      final goalWeight = goal.nutritionFactors[nutrient] ?? 0;
      macroScore += foodValue * goalWeight;
    }

    // Micronutrient Alignment
    for (final vitamin in Vetamins.values) {
      final foodValue = food.vitamins[vitamin] ?? 0;
      final goalWeight = goal.vetaminsFactors[vitamin] ?? 0;
      microScore += foodValue * goalWeight;
    }
    for (final mineral in Minerals.values) {
      final foodValue = food.minerals[mineral] ?? 0;
      final goalWeight = goal.mineralsFactors[mineral] ?? 0;
      microScore += foodValue * goalWeight;
    }

    // Calorie Consideration
    calorieScore = (goal.maxPositiveCalories -
            (goal.maxPositiveCalories - food.calories).abs()) /
        goal.maxPositiveCalories;

    // Normalization (Simplified - assumes values are non-negative)
    final maxMacro = Nutrition.values.length *
        1.0; // Max possible macro score (all nutrients at max value 1.0, which rarely happens)
    macroScore = maxMacro != 0.0 ? macroScore / maxMacro : 0;

    final maxMicro = (Vetamins.values.length + Minerals.values.length) *
        1.0; // Similar for micro
    microScore = maxMicro != 0.0 ? microScore / maxMicro : 0;

    // Weighting and Final Score

    final double finalScore =
        0.5 * macroScore + 0.3 * microScore + 0.2 * calorieScore;

    return finalScore;
  }

  static double ranker4(Goal goal, Food food) {
    double weightedNutrientScore = 0;
    double calorieScore = 0;
    double penaltyScore = 0;

    // Weighted Nutrient Score
    goal.nutritionFactors.forEach((nutrient, weight) {
      if (food.nutritions.containsKey(nutrient)) {
        double normalizedValue = food.nutritions[nutrient]! /
            100; // Example normalization: Adjust as needed
        weightedNutrientScore += normalizedValue * weight;
      }
    });
    goal.vetaminsFactors.forEach((vetamins, weight) {
      if (food.vitamins.containsKey(vetamins)) {
        double normalizedValue = food.vitamins[vetamins]! /
            100; // Example normalization: Adjust as needed
        weightedNutrientScore += normalizedValue * weight;
      }
    });
    goal.mineralsFactors.forEach((minerals, weight) {
      if (food.minerals.containsKey(minerals)) {
        double normalizedValue = food.minerals[minerals]! /
            100; // Example normalization: Adjust as needed
        weightedNutrientScore += normalizedValue * weight;
      }
    });

    // Calorie Score (Weight Loss)
    if (goal.name == "weight") {
      calorieScore = max(
          0,
          (goal.maxPositiveCalories - food.calories) /
              goal.maxPositiveCalories);
    }
    // Calorie Score (Energy/Focus - Example Gaussian approach)
    else if (goal.name == "Energy" || goal.name == "Focus") {
      double optimalCalories = 200; // Example: Adjust per goal
      double stdDev = 50; // Example: Adjust for curve width
      calorieScore = exp(
          -(pow(food.calories - optimalCalories, 2) / (2 * pow(stdDev, 2))));
    }

    //Penalty Score (Example: Sugar penalty for weight loss)

    if (goal.name == "weight" &&
        food.nutritions.containsKey(Nutrition.sugars)) {
      penaltyScore = -0.5 *
          (food.nutritions[Nutrition.sugars]! /
              100); // Example: Adjust as needed
    }

    return weightedNutrientScore + calorieScore + penaltyScore;
  }
}

class Goal extends Equatable {
  final Map<Nutrition, double> nutritionFactors;
  final Map<Vetamins, double> vetaminsFactors;
  final Map<Minerals, double> mineralsFactors;
  final double maxPositiveCalories;
  final String id;
  final String name;
  final String longName;
  final String description;
  final String picture;
  final String duration;
  final String category;
  final String rating;

  const Goal({
    required this.nutritionFactors,
    required this.maxPositiveCalories,
    required this.vetaminsFactors,
    required this.mineralsFactors,
    required this.name,
    required this.id,
    required this.longName,
    required this.description,
    required this.picture,
    required this.duration,
    required this.category,
    required this.rating,
  });

  static double rank(Food food, Goal goal) {
    final r1 = _FoodRanker.ranker1(goal, food);
    final r2 = _FoodRanker.ranker2(goal, food);
    final r3 = _FoodRanker.ranker3(goal, food);
    final r4 = _FoodRanker.ranker4(goal, food);

    return (r1 + r2 + r3 + r4) / 4;
  }

  Map<String, dynamic> toJson() {
    return {
      "nutritionFactors": NutritionId.serialize(nutritionFactors),
      "vetaminsFactors": VetaminsId.serialize(vetaminsFactors),
      "mineralsFactors": MineralsId.serialize(mineralsFactors),
      "maxPositiveCalories": maxPositiveCalories,
      "id": id,
      "name": name,
      "longName": longName,
      "description": description,
      "picture": picture,
      "duration": duration,
      "category": category,
      "rating": rating,
    };
  }

  static Goal fromJson(Map<String, dynamic> data) {
    return Goal(
      nutritionFactors: NutritionId.deserialize(
          Map<String, double>.from(data["nutritionFactors"])),
      vetaminsFactors: VetaminsId.deserialize(
          Map<String, double>.from(data["vetaminsFactors"])),
      mineralsFactors: MineralsId.deserialize(
          Map<String, double>.from(data["mineralsFactors"])),
      maxPositiveCalories: data["maxPositiveCalories"],
      id: data["id"],
      name: data["name"],
      longName: data["longName"],
      description: data["description"],
      picture: data["picture"],
      duration: data["duration"],
      category: data["category"],
      rating: data["rating"],
    );
  }

  @override
  List<Object?> get props => [id];
}
