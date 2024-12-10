import 'dart:math';

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

class Goal {
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
}

const List<Goal> goalDB = [
  Goal(
    name: "Energy",
    id: "1",
    longName: "Boost Energy",
    description:
        "Prioritize complex carbohydrates, healthy fats, and lean protein for sustained energy. Limit sugars and processed foods to avoid energy crashes.",
    picture: "assets/energy.png",
    duration: "1 month",
    category: "performance",
    rating: "8 / 10",
    nutritionFactors: {
      Nutrition.carbohydrates: 0.5, // Moderate carbs
      Nutrition.fats: 0.3, // Moderate healthy fats
      Nutrition.protein: 0.2, // Moderate protein
      Nutrition.fiber: 0.2, // Prioritize Fiber for stable energy
      Nutrition.sugars: 0.05, // Minimize Added Sugars
    },
    vetaminsFactors: {
      Vetamins.b12: 0.8, // Important for energy metabolism
      Vetamins.c: 0.6,
      Vetamins.d: 0.5, // Supports energy levels
      Vetamins.b1: 0.6,
      Vetamins.b2: 0.6,
      Vetamins.b3: 0.6,
    },
    mineralsFactors: {
      Minerals.iron: 0.7, // Prevents fatigue
      Minerals.magnesium: 0.6, // Important for energy production
      Minerals.potassium: 0.2
    },
    maxPositiveCalories: 250, // Example: Adjust as needed.
  ),
  Goal(
    name: "Focus",
    id: "2",

    longName: "Increase Focus",
    description:
        "Focus on foods rich in omega-3s, antioxidants, and B vitamins to support brain health and cognitive function. Limit saturated fats and added sugars.",
    picture: "assets/focus.png",
    duration: "1 month",
    category: "performance",
    rating: "9 / 10",
    nutritionFactors: {
      Nutrition.omega3: 0.8, // Crucial for Brain function
      Nutrition.antioxidants: 0.7,
      Nutrition.aminoAcids: 0.4,
      Nutrition.sugars: 0.05,
      Nutrition.cholesterol: 0.3,
    },
    vetaminsFactors: {
      Vetamins.b6: 0.9, // supports dopamine and focus
      Vetamins.b9: 0.8,
      Vetamins.b12: 0.9,
      Vetamins.d: 0.7, // Important for brain health
      Vetamins.e: 0.6,
      Vetamins.c: 0.6,
    },
    mineralsFactors: {
      Minerals.iron: 0.7,
      Minerals.zinc: 0.8, // Essential for cognitive function
      Minerals.magnesium: 0.7, // Supports nerve function
    },
    maxPositiveCalories: 200, // Example: Adjust as needed.
  ),
  Goal(
    name: "weight",
    id: "3",

    longName: "Loose Weight",
    description:
        "Prioritize lean protein, fiber, and complex carbs. Control portions and create a calorie deficit for effective weight management.",
    picture: "assets/weight.png",
    duration: "3 month",
    category: "Health",
    rating: "7 / 10",
    nutritionFactors: {
      Nutrition.fiber: 0.6,
      Nutrition.protein: 0.4,
      Nutrition.carbohydrates: 0.4,
      Nutrition.sugars: 0.05,
      Nutrition.fats: 0.2,
    },
    vetaminsFactors: {
      // A balanced vitamin profile is crucial during weight loss.
      Vetamins.a: 0.2,
      Vetamins.b12: 0.4, // Important for energy metabolism
      Vetamins.c: 0.4,
      Vetamins.d: 0.4, // Supports energy levels and overall health
    },
    mineralsFactors: {
      Minerals.potassium: 0.5,
      Minerals.calcium: 0.5,
      Minerals.iron:
          0.6, // Iron is often important during weight loss, especially for women.
    },
    maxPositiveCalories: 150, // Example: Adjust as needed.
  ),
];
