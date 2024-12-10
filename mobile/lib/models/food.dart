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

final List<Food> foodDB = [
  Food(
    code: '001',
    id: '001',
    name: 'Whole Milk',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Milk',
    quantity: 1000.0,
    avgDialyConsumption: 250.0,
    calories: 60.0,
    nutritions: {
      Nutrition.protein: 3.2,
      Nutrition.saturatedFats: 1.5,
      Nutrition.sugars: 4.5,
      Nutrition.cholesterol: 10.0,
    },
    minerals: {
      Minerals.calcium: 125.0,
      Minerals.potassium: 160.0,
      Minerals.magnesium: 12.0,
    },
    vitamins: {
      Vetamins.a: 0.5,
      Vetamins.b12: 0.4,
      Vetamins.d: 1.0,
    },
  ),
  Food(
    code: '002',
    id: '002',
    name: 'Cheddar Cheese',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Cheese',
    quantity: 100.0,
    avgDialyConsumption: 20.0,
    calories: 402.0,
    nutritions: {
      Nutrition.protein: 25.0,
      Nutrition.saturatedFats: 20.0,
      Nutrition.transFats: 0.5,
      Nutrition.cholesterol: 105.0,
    },
    minerals: {
      Minerals.calcium: 721.0,
      Minerals.potassium: 98.0,
      Minerals.sodium: 621.0,
    },
    vitamins: {
      Vetamins.a: 1.0,
      Vetamins.b2: 0.5,
      Vetamins.k: 0.1,
    },
  ),
  Food(
    code: '003',
    id: '003',
    name: 'Greek Yogurt',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Yogurt',
    quantity: 150.0,
    avgDialyConsumption: 150.0,
    calories: 59.0,
    nutritions: {
      Nutrition.protein: 10.0,
      Nutrition.sugars: 3.0,
      Nutrition.saturatedFats: 0.4,
    },
    minerals: {
      Minerals.calcium: 120.0,
      Minerals.potassium: 141.0,
      Minerals.magnesium: 11.0,
    },
    vitamins: {
      Vetamins.a: 0.3,
      Vetamins.b12: 0.2,
      Vetamins.d: 0.1,
    },
  ),
  Food(
    code: '004',
    id: '004',
    name: 'Almond Milk',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy Alternatives',
    subcategory: 'Milk Alternatives',
    quantity: 1000.0,
    avgDialyConsumption: 250.0,
    calories: 30.0,
    nutritions: {
      Nutrition.protein: 1.0,
      Nutrition.sugars: 0.2,
      Nutrition.fiber: 1.0,
    },
    minerals: {
      Minerals.calcium: 450.0,
      Minerals.potassium: 150.0,
      Minerals.sodium: 110.0,
    },
    vitamins: {
      Vetamins.e: 2.0,
      Vetamins.b12: 0.3,
      Vetamins.d: 0.4,
    },
  ),
  Food(
    code: '005',
    id: '005',
    name: 'Butter',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Butter',
    quantity: 100.0,
    avgDialyConsumption: 15.0,
    calories: 717.0,
    nutritions: {
      Nutrition.saturatedFats: 51.0,
      Nutrition.transFats: 3.0,
      Nutrition.cholesterol: 215.0,
    },
    minerals: {
      Minerals.sodium: 11.0,
    },
    vitamins: {
      Vetamins.a: 0.68,
      Vetamins.d: 0.2,
    },
  ),
  Food(
    code: '006',
    id: '006',
    name: 'Wheat Bread',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Bread',
    quantity: 500.0,
    avgDialyConsumption: 60.0,
    calories: 247.0,
    nutritions: {
      Nutrition.protein: 8.0,
      Nutrition.fiber: 2.7,
      Nutrition.starch: 45.0,
    },
    minerals: {
      Minerals.iron: 3.6,
      Minerals.magnesium: 34.0,
      Minerals.zinc: 1.2,
    },
    vitamins: {
      Vetamins.b1: 0.3,
      Vetamins.b9: 0.14,
    },
  ),
  Food(
    code: '007',
    id: '007',
    name: 'Brown Rice',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Rice',
    quantity: 1000.0,
    avgDialyConsumption: 180.0,
    calories: 370.0,
    nutritions: {
      Nutrition.protein: 7.5,
      Nutrition.fiber: 4.5,
      Nutrition.starch: 80.0,
    },
    minerals: {
      Minerals.magnesium: 110.0,
      Minerals.phosphorus: 160.0,
      Minerals.selenium: 15.0,
    },
    vitamins: {
      Vetamins.b3: 5.0,
      Vetamins.b6: 0.4,
    },
  ),
  Food(
    code: '008',
    id: '008',
    name: 'Quinoa',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Seeds',
    quantity: 1000.0,
    avgDialyConsumption: 180.0,
    calories: 368.0,
    nutritions: {
      Nutrition.protein: 14.0,
      Nutrition.fiber: 7.0,
      Nutrition.starch: 64.0,
    },
    minerals: {
      Minerals.magnesium: 197.0,
      Minerals.phosphorus: 457.0,
      Minerals.zinc: 3.1,
    },
    vitamins: {
      Vetamins.b2: 0.4,
      Vetamins.b6: 0.5,
    },
  ),
  Food(
    code: '009',
    id: '009',
    name: 'Apples',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Fresh Fruits',
    quantity: 200.0,
    avgDialyConsumption: 150.0,
    calories: 52.0,
    nutritions: {
      Nutrition.sugars: 10.0,
      Nutrition.fiber: 2.4,
    },
    minerals: {
      Minerals.potassium: 107.0,
      Minerals.sodium: 1.0,
    },
    vitamins: {
      Vetamins.c: 4.6,
    },
  ),
  Food(
    code: '010',
    id: '010',
    name: 'Bananas',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Fresh Fruits',
    quantity: 200.0,
    avgDialyConsumption: 120.0,
    calories: 96.0,
    nutritions: {
      Nutrition.sugars: 12.2,
      Nutrition.fiber: 2.6,
      Nutrition.starch: 22.0,
    },
    minerals: {
      Minerals.potassium: 358.0,
      Minerals.magnesium: 27.0,
    },
    vitamins: {
      Vetamins.b6: 0.4,
      Vetamins.c: 8.7,
    },
  ),
  Food(
    code: '011',
    id: '011',
    name: 'Carrots',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 80.0,
    calories: 41.0,
    nutritions: {
      Nutrition.fiber: 2.8,
      Nutrition.sugars: 4.7,
    },
    minerals: {
      Minerals.potassium: 320.0,
      Minerals.sodium: 69.0,
    },
    vitamins: {
      Vetamins.a: 8.3,
      Vetamins.c: 5.9,
      Vetamins.k: 13.2,
    },
  ),
  Food(
    code: '012',
    id: '012',
    name: 'Broccoli',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Vegetables',
    quantity: 200.0,
    avgDialyConsumption: 150.0,
    calories: 55.0,
    nutritions: {
      Nutrition.protein: 4.2,
      Nutrition.fiber: 2.6,
      Nutrition.sugars: 2.3,
    },
    minerals: {
      Minerals.calcium: 47.0,
      Minerals.potassium: 316.0,
      Minerals.iron: 0.7,
    },
    vitamins: {
      Vetamins.c: 81.2,
      Vetamins.k: 101.6,
    },
  ),
  Food(
    code: '013',
    id: '013',
    name: 'Chicken Breast',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat',
    subcategory: 'Poultry',
    quantity: 150.0,
    avgDialyConsumption: 150.0,
    calories: 165.0,
    nutritions: {
      Nutrition.protein: 31.0,
      Nutrition.saturatedFats: 1.0,
      Nutrition.transFats: 0.0,
    },
    minerals: {
      Minerals.phosphorus: 220.0,
      Minerals.potassium: 256.0,
    },
    vitamins: {
      Vetamins.b3: 10.8,
      Vetamins.b6: 0.9,
    },
  ),
  Food(
    code: '014',
    id: '014',
    name: 'Salmon',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat',
    subcategory: 'Fish',
    quantity: 200.0,
    avgDialyConsumption: 150.0,
    calories: 206.0,
    nutritions: {
      Nutrition.protein: 22.0,
      Nutrition.omega3: 1.8,
      Nutrition.saturatedFats: 3.1,
    },
    minerals: {
      Minerals.potassium: 363.0,
      Minerals.sodium: 59.0,
    },
    vitamins: {
      Vetamins.d: 11.0,
      Vetamins.b12: 3.2,
    },
  ),
  Food(
    code: '015',
    id: '015',
    name: 'Eggs',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Eggs',
    quantity: 60.0,
    avgDialyConsumption: 120.0,
    calories: 155.0,
    nutritions: {
      Nutrition.protein: 12.6,
      Nutrition.saturatedFats: 3.1,
      Nutrition.cholesterol: 373.0,
    },
    minerals: {
      Minerals.iron: 1.1,
      Minerals.phosphorus: 99.0,
    },
    vitamins: {
      Vetamins.a: 0.5,
      Vetamins.b2: 0.5,
      Vetamins.d: 1.1,
    },
  ),
  Food(
    code: '016',
    id: '016',
    name: 'Almonds',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Nuts',
    quantity: 100.0,
    avgDialyConsumption: 30.0,
    calories: 576.0,
    nutritions: {
      Nutrition.protein: 21.0,
      Nutrition.fiber: 12.5,
      Nutrition.saturatedFats: 3.7,
    },
    minerals: {
      Minerals.magnesium: 270.0,
      Minerals.calcium: 264.0,
    },
    vitamins: {
      Vetamins.e: 25.6,
    },
  ),
  Food(
    code: '017',
    id: '017',
    name: 'Spinach',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Vegetables',
    quantity: 200.0,
    avgDialyConsumption: 100.0,
    calories: 23.0,
    nutritions: {
      Nutrition.protein: 2.9,
      Nutrition.fiber: 2.2,
      Nutrition.sugars: 0.4,
    },
    minerals: {
      Minerals.iron: 2.7,
      Minerals.calcium: 99.0,
      Minerals.magnesium: 79.0,
    },
    vitamins: {
      Vetamins.a: 9.4,
      Vetamins.c: 28.1,
      Vetamins.k: 482.9,
    },
  ),
  Food(
    code: '018',
    id: '018',
    name: 'Milk (Whole)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Milk',
    quantity: 1000.0,
    avgDialyConsumption: 250.0,
    calories: 42.0,
    nutritions: {
      Nutrition.protein: 3.4,
      Nutrition.sugars: 5.1,
      Nutrition.saturatedFats: 1.0,
    },
    minerals: {
      Minerals.calcium: 125.0,
      Minerals.phosphorus: 95.0,
      Minerals.potassium: 150.0,
    },
    vitamins: {
      Vetamins.b12: 0.9,
      Vetamins.d: 1.2,
    },
  ),
  Food(
    code: '019',
    id: '019',
    name: 'Peanuts',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Nuts',
    quantity: 100.0,
    avgDialyConsumption: 30.0,
    calories: 567.0,
    nutritions: {
      Nutrition.protein: 25.8,
      Nutrition.fiber: 8.5,
      Nutrition.saturatedFats: 6.8,
    },
    minerals: {
      Minerals.magnesium: 168.0,
      Minerals.phosphorus: 376.0,
      Minerals.potassium: 705.0,
    },
    vitamins: {
      Vetamins.b3: 12.1,
      Vetamins.e: 8.3,
    },
  ),
  Food(
    code: '020',
    id: '020',
    name: 'Greek Yogurt',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Yogurt',
    quantity: 150.0,
    avgDialyConsumption: 150.0,
    calories: 59.0,
    nutritions: {
      Nutrition.protein: 10.0,
      Nutrition.sugars: 3.6,
      Nutrition.saturatedFats: 0.4,
    },
    minerals: {
      Minerals.calcium: 110.0,
      Minerals.potassium: 141.0,
    },
    vitamins: {
      Vetamins.b12: 0.7,
    },
  ),
  Food(
    code: '021',
    id: '021',
    name: 'Oats',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Cereals',
    quantity: 100.0,
    avgDialyConsumption: 40.0,
    calories: 389.0,
    nutritions: {
      Nutrition.protein: 16.9,
      Nutrition.fiber: 10.6,
      Nutrition.starch: 66.3,
    },
    minerals: {
      Minerals.iron: 4.7,
      Minerals.magnesium: 177.0,
      Minerals.zinc: 3.1,
    },
    vitamins: {
      Vetamins.b1: 0.8,
      Vetamins.b5: 1.3,
    },
  ),
  Food(
    code: '022',
    id: '022',
    name: 'Sweet Potatoes',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 200.0,
    avgDialyConsumption: 130.0,
    calories: 86.0,
    nutritions: {
      Nutrition.fiber: 3.0,
      Nutrition.starch: 20.0,
      Nutrition.sugars: 4.2,
    },
    minerals: {
      Minerals.potassium: 337.0,
      Minerals.calcium: 30.0,
      Minerals.iron: 0.6,
    },
    vitamins: {
      Vetamins.a: 7.6,
      Vetamins.c: 2.4,
    },
  ),
  Food(
    code: '023',
    id: '023',
    name: 'Oranges',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Citrus',
    quantity: 150.0,
    avgDialyConsumption: 180.0,
    calories: 47.0,
    nutritions: {
      Nutrition.sugars: 9.4,
      Nutrition.fiber: 2.4,
    },
    minerals: {
      Minerals.potassium: 181.0,
      Minerals.calcium: 40.0,
    },
    vitamins: {
      Vetamins.c: 53.2,
      Vetamins.a: 0.1,
    },
  ),
  Food(
    code: '024',
    id: '024',
    name: 'Tofu',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Protein Alternatives',
    subcategory: 'Soy Products',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 76.0,
    nutritions: {
      Nutrition.protein: 8.1,
      Nutrition.saturatedFats: 0.6,
      Nutrition.fiber: 0.4,
    },
    minerals: {
      Minerals.calcium: 350.0,
      Minerals.iron: 1.7,
    },
    vitamins: {
      Vetamins.k: 2.0,
    },
  ),
  Food(
    code: '025',
    id: '025',
    name: 'Cucumber',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Fresh Vegetables',
    quantity: 300.0,
    avgDialyConsumption: 200.0,
    calories: 16.0,
    nutritions: {
      Nutrition.fiber: 0.7,
      Nutrition.sugars: 1.7,
    },
    minerals: {
      Minerals.potassium: 147.0,
      Minerals.sodium: 2.0,
    },
    vitamins: {
      Vetamins.k: 16.4,
      Vetamins.c: 2.8,
    },
  ),
  Food(
    code: '026',
    id: '026',
    name: 'Apples',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tree Fruits',
    quantity: 200.0,
    avgDialyConsumption: 150.0,
    calories: 52.0,
    nutritions: {
      Nutrition.sugars: 10.4,
      Nutrition.fiber: 2.4,
    },
    minerals: {
      Minerals.potassium: 107.0,
      Minerals.calcium: 6.0,
    },
    vitamins: {
      Vetamins.c: 4.6,
    },
  ),
  Food(
    code: '027',
    id: '027',
    name: 'Chicken Breast',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat & Poultry',
    subcategory: 'Poultry',
    quantity: 150.0,
    avgDialyConsumption: 200.0,
    calories: 165.0,
    nutritions: {
      Nutrition.protein: 31.0,
      Nutrition.saturatedFats: 1.0,
    },
    minerals: {
      Minerals.phosphorus: 220.0,
      Minerals.potassium: 256.0,
    },
    vitamins: {
      Vetamins.b3: 14.8,
      Vetamins.b6: 0.6,
    },
  ),
  Food(
    code: '028',
    id: '028',
    name: 'Almonds',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Nuts',
    quantity: 100.0,
    avgDialyConsumption: 30.0,
    calories: 579.0,
    nutritions: {
      Nutrition.protein: 21.2,
      Nutrition.fiber: 12.5,
      Nutrition.monounsaturatedFats: 31.0,
    },
    minerals: {
      Minerals.magnesium: 268.0,
      Minerals.calcium: 264.0,
      Minerals.iron: 3.7,
    },
    vitamins: {
      Vetamins.e: 25.6,
      Vetamins.b2: 1.1,
    },
  ),
  Food(
    code: '029',
    id: '029',
    name: 'Eggs (Boiled)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Protein',
    subcategory: 'Eggs',
    quantity: 50.0,
    avgDialyConsumption: 100.0,
    calories: 155.0,
    nutritions: {
      Nutrition.protein: 13.0,
      Nutrition.cholesterol: 373.0,
      Nutrition.saturatedFats: 3.3,
    },
    minerals: {
      Minerals.selenium: 31.7,
      Minerals.phosphorus: 126.0,
    },
    vitamins: {
      Vetamins.a: 0.26,
      Vetamins.d: 0.82,
      Vetamins.b12: 0.89,
    },
  ),
  Food(
    code: '030',
    id: '030',
    name: 'Brown Rice',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Rice',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 123.0,
    nutritions: {
      Nutrition.fiber: 1.6,
      Nutrition.protein: 2.6,
      Nutrition.starch: 25.5,
    },
    minerals: {
      Minerals.magnesium: 43.0,
      Minerals.phosphorus: 83.0,
      Minerals.potassium: 86.0,
    },
    vitamins: {
      Vetamins.b3: 1.6,
      Vetamins.b1: 0.2,
    },
  ),
  Food(
    code: '031',
    id: '031',
    name: 'Bananas',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 120.0,
    avgDialyConsumption: 100.0,
    calories: 89.0,
    nutritions: {
      Nutrition.sugars: 12.2,
      Nutrition.fiber: 2.6,
    },
    minerals: {
      Minerals.potassium: 358.0,
      Minerals.magnesium: 27.0,
    },
    vitamins: {
      Vetamins.c: 8.7,
      Vetamins.b6: 0.4,
    },
  ),
  Food(
    code: '032',
    id: '032',
    name: 'Carrots',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 130.0,
    calories: 41.0,
    nutritions: {
      Nutrition.fiber: 2.8,
      Nutrition.sugars: 4.7,
    },
    minerals: {
      Minerals.potassium: 320.0,
      Minerals.calcium: 33.0,
    },
    vitamins: {
      Vetamins.a: 8.4,
      Vetamins.k: 13.2,
      Vetamins.c: 5.9,
    },
  ),
  Food(
    code: '033',
    id: '033',
    name: 'Lentils',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Legumes',
    subcategory: 'Pulses',
    quantity: 100.0,
    avgDialyConsumption: 60.0,
    calories: 116.0,
    nutritions: {
      Nutrition.protein: 9.0,
      Nutrition.fiber: 7.9,
      Nutrition.starch: 20.1,
    },
    minerals: {
      Minerals.iron: 3.3,
      Minerals.zinc: 1.3,
      Minerals.magnesium: 36.0,
    },
    vitamins: {
      Vetamins.b1: 0.3,
      Vetamins.b9: 181.0,
    },
  ),
  Food(
    code: '034',
    id: '034',
    name: 'Cheddar Cheese',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Cheese',
    quantity: 50.0,
    avgDialyConsumption: 30.0,
    calories: 402.0,
    nutritions: {
      Nutrition.protein: 25.0,
      Nutrition.saturatedFats: 19.0,
      Nutrition.cholesterol: 105.0,
    },
    minerals: {
      Minerals.calcium: 721.0,
      Minerals.phosphorus: 512.0,
    },
    vitamins: {
      Vetamins.a: 0.27,
      Vetamins.d: 0.19,
      Vetamins.k: 2.4,
    },
  ),
  Food(
    code: '035',
    id: '035',
    name: 'Avocados',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 150.0,
    avgDialyConsumption: 100.0,
    calories: 160.0,
    nutritions: {
      Nutrition.fiber: 6.7,
      Nutrition.monounsaturatedFats: 14.7,
      Nutrition.sugars: 0.7,
    },
    minerals: {
      Minerals.potassium: 485.0,
      Minerals.magnesium: 29.0,
    },
    vitamins: {
      Vetamins.k: 20.0,
      Vetamins.b5: 1.4,
    },
  ),
  Food(
    code: '036',
    id: '036',
    name: 'Spinach',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Greens',
    quantity: 100.0,
    avgDialyConsumption: 70.0,
    calories: 23.0,
    nutritions: {
      Nutrition.fiber: 2.2,
      Nutrition.protein: 2.9,
    },
    minerals: {
      Minerals.iron: 2.7,
      Minerals.magnesium: 79.0,
      Minerals.potassium: 558.0,
    },
    vitamins: {
      Vetamins.a: 9.4,
      Vetamins.k: 483.0,
      Vetamins.c: 28.1,
    },
  ),
  Food(
    code: '037',
    id: '037',
    name: 'Yogurt (Plain)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Fermented Dairy',
    quantity: 150.0,
    avgDialyConsumption: 200.0,
    calories: 59.0,
    nutritions: {
      Nutrition.protein: 10.0,
      Nutrition.sugars: 3.2,
    },
    minerals: {
      Minerals.calcium: 110.0,
      Minerals.phosphorus: 100.0,
    },
    vitamins: {
      Vetamins.b12: 0.8,
      Vetamins.b2: 0.2,
    },
  ),
  Food(
    code: '038',
    id: '038',
    name: 'Sweet Potatoes',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 130.0,
    calories: 86.0,
    nutritions: {
      Nutrition.fiber: 3.0,
      Nutrition.starch: 20.1,
    },
    minerals: {
      Minerals.potassium: 337.0,
      Minerals.magnesium: 25.0,
    },
    vitamins: {
      Vetamins.a: 9.6,
      Vetamins.c: 2.4,
    },
  ),
  Food(
    code: '039',
    id: '039',
    name: 'Salmon (Grilled)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Seafood',
    subcategory: 'Fish',
    quantity: 150.0,
    avgDialyConsumption: 120.0,
    calories: 206.0,
    nutritions: {
      Nutrition.protein: 22.0,
      Nutrition.omega3: 2.0,
    },
    minerals: {
      Minerals.selenium: 36.5,
      Minerals.phosphorus: 250.0,
    },
    vitamins: {
      Vetamins.d: 12.5,
      Vetamins.b12: 2.8,
    },
  ),
  Food(
    code: '040',
    id: '040',
    name: 'Oats',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Cereals',
    quantity: 100.0,
    avgDialyConsumption: 50.0,
    calories: 389.0,
    nutritions: {
      Nutrition.fiber: 10.6,
      Nutrition.protein: 16.9,
      Nutrition.starch: 66.3,
    },
    minerals: {
      Minerals.iron: 4.7,
      Minerals.zinc: 3.6,
      Minerals.magnesium: 138.0,
    },
    vitamins: {
      Vetamins.b1: 0.5,
      Vetamins.b3: 1.1,
    },
  ),
  Food(
    code: '041',
    id: '041',
    name: 'Tomatoes',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Fruiting Vegetables',
    quantity: 150.0,
    avgDialyConsumption: 100.0,
    calories: 18.0,
    nutritions: {
      Nutrition.sugars: 2.6,
      Nutrition.fiber: 1.2,
    },
    minerals: {
      Minerals.potassium: 237.0,
      Minerals.magnesium: 11.0,
    },
    vitamins: {
      Vetamins.a: 0.6,
      Vetamins.c: 14.0,
    },
  ),
  Food(
    code: '042',
    id: '042',
    name: 'Peanuts',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Legumes',
    quantity: 100.0,
    avgDialyConsumption: 40.0,
    calories: 567.0,
    nutritions: {
      Nutrition.protein: 25.8,
      Nutrition.fiber: 8.5,
      Nutrition.monounsaturatedFats: 24.4,
    },
    minerals: {
      Minerals.magnesium: 168.0,
      Minerals.potassium: 705.0,
    },
    vitamins: {
      Vetamins.b3: 12.1,
      Vetamins.e: 8.3,
    },
  ),
  Food(
    code: '043',
    id: '043',
    name: 'Oranges',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Citrus Fruits',
    quantity: 130.0,
    avgDialyConsumption: 150.0,
    calories: 47.0,
    nutritions: {
      Nutrition.sugars: 9.0,
      Nutrition.fiber: 2.4,
    },
    minerals: {
      Minerals.potassium: 181.0,
      Minerals.calcium: 40.0,
    },
    vitamins: {
      Vetamins.c: 53.2,
      Vetamins.a: 0.2,
    },
  ),
  Food(
    code: '044',
    id: '044',
    name: 'Shrimp (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Seafood',
    subcategory: 'Shellfish',
    quantity: 100.0,
    avgDialyConsumption: 80.0,
    calories: 99.0,
    nutritions: {
      Nutrition.protein: 24.0,
      Nutrition.cholesterol: 189.0,
    },
    minerals: {
      Minerals.selenium: 34.0,
      Minerals.phosphorus: 201.0,
    },
    vitamins: {
      Vetamins.b12: 1.3,
      Vetamins.b6: 0.1,
    },
  ),
  Food(
    code: '045',
    id: '045',
    name: 'Honey',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Sweeteners',
    subcategory: 'Natural Sweeteners',
    quantity: 100.0,
    avgDialyConsumption: 20.0,
    calories: 304.0,
    nutritions: {
      Nutrition.sugars: 82.4,
    },
    minerals: {
      Minerals.potassium: 52.0,
      Minerals.calcium: 6.0,
    },
    vitamins: {
      Vetamins.c: 0.5,
    },
  ),
  Food(
    code: '046',
    id: '046',
    name: 'Chicken Breast (Grilled)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat',
    subcategory: 'Poultry',
    quantity: 150.0,
    avgDialyConsumption: 120.0,
    calories: 165.0,
    nutritions: {
      Nutrition.protein: 31.0,
      Nutrition.fats: 3.6,
    },
    minerals: {
      Minerals.phosphorus: 228.0,
      Minerals.selenium: 26.0,
    },
    vitamins: {
      Vetamins.b3: 12.0,
      Vetamins.b6: 0.9,
    },
  ),
  Food(
    code: '047',
    id: '047',
    name: 'Lentils (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Legumes',
    subcategory: 'Pulses',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 116.0,
    nutritions: {
      Nutrition.fiber: 7.9,
      Nutrition.protein: 9.0,
      Nutrition.carbohydrates: 20.1,
    },
    minerals: {
      Minerals.iron: 3.3,
      Minerals.magnesium: 36.0,
      Minerals.potassium: 369.0,
    },
    vitamins: {
      Vetamins.b1: 0.2,
      Vetamins.b6: 0.3,
    },
  ),
  Food(
    code: '048',
    id: '048',
    name: 'Bananas',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 120.0,
    avgDialyConsumption: 150.0,
    calories: 89.0,
    nutritions: {
      Nutrition.fiber: 2.6,
      Nutrition.sugars: 12.2,
    },
    minerals: {
      Minerals.potassium: 358.0,
      Minerals.magnesium: 27.0,
    },
    vitamins: {
      Vetamins.c: 8.7,
      Vetamins.b6: 0.4,
    },
  ),
  Food(
    code: '049',
    id: '049',
    name: 'Cheddar Cheese',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Cheese',
    quantity: 30.0,
    avgDialyConsumption: 40.0,
    calories: 402.0,
    nutritions: {
      Nutrition.fats: 33.1,
      Nutrition.protein: 25.0,
    },
    minerals: {
      Minerals.calcium: 721.0,
      Minerals.phosphorus: 512.0,
    },
    vitamins: {
      Vetamins.b12: 1.0,
      Vetamins.a: 0.3,
    },
  ),
  Food(
    code: '050',
    id: '050',
    name: 'Brown Rice (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Cereal Grains',
    quantity: 150.0,
    avgDialyConsumption: 200.0,
    calories: 123.0,
    nutritions: {
      Nutrition.fiber: 1.8,
      Nutrition.carbohydrates: 25.6,
    },
    minerals: {
      Minerals.magnesium: 44.0,
      Minerals.phosphorus: 83.0,
    },
    vitamins: {
      Vetamins.b1: 0.2,
      Vetamins.b3: 1.4,
    },
  ),
  Food(
    code: '051',
    id: '051',
    name: 'Dark Chocolate (70% Cocoa)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Snacks',
    subcategory: 'Confectionery',
    quantity: 100.0,
    avgDialyConsumption: 20.0,
    calories: 598.0,
    nutritions: {
      Nutrition.fats: 42.6,
      Nutrition.sugars: 24.0,
    },
    minerals: {
      Minerals.iron: 11.9,
      Minerals.magnesium: 228.0,
    },
    vitamins: {
      Vetamins.b1: 0.1,
      Vetamins.e: 0.6,
    },
  ),
  Food(
    code: '052',
    id: '052',
    name: 'Eggs (Boiled)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Protein',
    subcategory: 'Eggs',
    quantity: 50.0,
    avgDialyConsumption: 100.0,
    calories: 155.0,
    nutritions: {
      Nutrition.protein: 12.6,
      Nutrition.fats: 10.6,
      Nutrition.cholesterol: 373.0,
    },
    minerals: {
      Minerals.iron: 1.2,
      Minerals.phosphorus: 86.0,
    },
    vitamins: {
      Vetamins.b12: 0.6,
      Vetamins.a: 0.4,
    },
  ),
  Food(
    code: '053',
    id: '053',
    name: 'Almonds',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Tree Nuts',
    quantity: 100.0,
    avgDialyConsumption: 30.0,
    calories: 576.0,
    nutritions: {
      Nutrition.protein: 21.2,
      Nutrition.fiber: 12.5,
      Nutrition.monounsaturatedFats: 32.0,
    },
    minerals: {
      Minerals.calcium: 264.0,
      Minerals.magnesium: 268.0,
    },
    vitamins: {
      Vetamins.e: 26.2,
      Vetamins.b2: 1.0,
    },
  ),
  Food(
    code: '054',
    id: '054',
    name: 'Avocado',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Berries',
    quantity: 150.0,
    avgDialyConsumption: 120.0,
    calories: 160.0,
    nutritions: {
      Nutrition.monounsaturatedFats: 15.0,
      Nutrition.fiber: 7.0,
    },
    minerals: {
      Minerals.potassium: 485.0,
      Minerals.magnesium: 29.0,
    },
    vitamins: {
      Vetamins.k: 20.0,
      Vetamins.c: 10.0,
    },
  ),
  Food(
    code: '055',
    id: '055',
    name: 'Broccoli (Steamed)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Cruciferous Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 55.0,
    nutritions: {
      Nutrition.fiber: 2.4,
      Nutrition.protein: 3.7,
    },
    minerals: {
      Minerals.calcium: 47.0,
      Minerals.potassium: 316.0,
    },
    vitamins: {
      Vetamins.c: 89.2,
      Vetamins.k: 92.5,
    },
  ),
  Food(
    code: '056',
    id: '056',
    name: 'Carrots (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 41.0,
    nutritions: {
      Nutrition.fiber: 2.8,
      Nutrition.sugars: 4.7,
    },
    minerals: {
      Minerals.potassium: 320.0,
      Minerals.calcium: 33.0,
    },
    vitamins: {
      Vetamins.a: 835.0,
      Vetamins.k: 13.2,
    },
  ),
  Food(
    code: '057',
    id: '057',
    name: 'Spinach (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Greens',
    quantity: 100.0,
    avgDialyConsumption: 200.0,
    calories: 23.0,
    nutritions: {
      Nutrition.fiber: 2.2,
      Nutrition.protein: 2.9,
    },
    minerals: {
      Minerals.iron: 2.7,
      Minerals.magnesium: 79.0,
    },
    vitamins: {
      Vetamins.k: 482.9,
      Vetamins.a: 469.0,
    },
  ),
  Food(
    code: '058',
    id: '058',
    name: 'Greek Yogurt (Plain, Full-Fat)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Yogurt',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 97.0,
    nutritions: {
      Nutrition.protein: 9.0,
      Nutrition.fats: 4.5,
    },
    minerals: {
      Minerals.calcium: 110.0,
      Minerals.phosphorus: 150.0,
    },
    vitamins: {
      Vetamins.b12: 0.8,
      Vetamins.a: 1.0,
    },
  ),
  Food(
    code: '059',
    id: '059',
    name: 'Quinoa (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Pseudocereal',
    quantity: 185.0,
    avgDialyConsumption: 150.0,
    calories: 120.0,
    nutritions: {
      Nutrition.protein: 4.1,
      Nutrition.fiber: 2.8,
    },
    minerals: {
      Minerals.magnesium: 64.0,
      Minerals.iron: 1.5,
    },
    vitamins: {
      Vetamins.b2: 0.1,
      Vetamins.b6: 0.1,
    },
  ),
  Food(
    code: '060',
    id: '060',
    name: 'Sweet Potatoes (Baked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 130.0,
    avgDialyConsumption: 150.0,
    calories: 112.0,
    nutritions: {
      Nutrition.fiber: 3.9,
      Nutrition.sugars: 5.4,
    },
    minerals: {
      Minerals.potassium: 438.0,
      Minerals.calcium: 39.0,
    },
    vitamins: {
      Vetamins.a: 192.2,
      Vetamins.c: 2.4,
    },
  ),
  Food(
    code: '061',
    id: '061',
    name: 'Walnuts',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Tree Nuts',
    quantity: 100.0,
    avgDialyConsumption: 30.0,
    calories: 654.0,
    nutritions: {
      Nutrition.fats: 65.2,
      Nutrition.omega3: 9.1,
    },
    minerals: {
      Minerals.magnesium: 158.0,
      Minerals.copper: 1.6,
    },
    vitamins: {
      Vetamins.b6: 0.5,
      Vetamins.e: 0.7,
    },
  ),
  Food(
    code: '062',
    id: '062',
    name: 'Blueberries (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Berries',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 57.0,
    nutritions: {
      Nutrition.fiber: 2.4,
      Nutrition.sugars: 9.7,
    },
    minerals: {
      Minerals.potassium: 77.0,
      Minerals.calcium: 6.0,
    },
    vitamins: {
      Vetamins.c: 9.7,
      Vetamins.k: 19.3,
    },
  ),
  Food(
    code: '063',
    id: '063',
    name: 'Oats (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Grains',
    subcategory: 'Cereal Grains',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 71.0,
    nutritions: {
      Nutrition.fiber: 1.7,
      Nutrition.protein: 2.5,
    },
    minerals: {
      Minerals.iron: 0.6,
      Minerals.magnesium: 27.0,
    },
    vitamins: {
      Vetamins.b1: 0.1,
      Vetamins.b3: 0.2,
    },
  ),
  Food(
    code: '064',
    id: '064',
    name: 'Salmon (Grilled)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat',
    subcategory: 'Seafood',
    quantity: 150.0,
    avgDialyConsumption: 120.0,
    calories: 206.0,
    nutritions: {
      Nutrition.protein: 22.0,
      Nutrition.omega3: 2.5,
    },
    minerals: {
      Minerals.selenium: 25.3,
      Minerals.potassium: 490.0,
    },
    vitamins: {
      Vetamins.d: 10.9,
      Vetamins.b12: 3.0,
    },
  ),
  Food(
    code: '065',
    id: '065',
    name: 'Pineapple (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 50.0,
    nutritions: {
      Nutrition.fiber: 1.4,
      Nutrition.sugars: 9.9,
    },
    minerals: {
      Minerals.potassium: 109.0,
      Minerals.magnesium: 12.0,
    },
    vitamins: {
      Vetamins.c: 47.8,
      Vetamins.b6: 0.1,
    },
  ),
  Food(
    code: '066',
    id: '066',
    name: 'Egg (Whole, Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy',
    subcategory: 'Eggs',
    quantity: 50.0,
    avgDialyConsumption: 100.0,
    calories: 68.0,
    nutritions: {
      Nutrition.protein: 5.5,
      Nutrition.fats: 4.8,
    },
    minerals: {
      Minerals.phosphorus: 95.0,
      Minerals.selenium: 15.0,
    },
    vitamins: {
      Vetamins.a: 270.0,
      Vetamins.d: 0.9,
    },
  ),
  Food(
    code: '067',
    id: '067',
    name: 'Almonds (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Tree Nuts',
    quantity: 100.0,
    avgDialyConsumption: 30.0,
    calories: 579.0,
    nutritions: {
      Nutrition.fats: 49.9,
      Nutrition.protein: 21.2,
    },
    minerals: {
      Minerals.magnesium: 268.0,
      Minerals.calcium: 264.0,
    },
    vitamins: {
      Vetamins.e: 25.6,
      Vetamins.b2: 1.1,
    },
  ),
  Food(
    code: '068',
    id: '068',
    name: 'Banana (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 89.0,
    nutritions: {
      Nutrition.sugars: 12.2,
      Nutrition.fiber: 2.6,
    },
    minerals: {
      Minerals.potassium: 358.0,
      Minerals.magnesium: 27.0,
    },
    vitamins: {
      Vetamins.b6: 0.4,
      Vetamins.c: 8.7,
    },
  ),
  Food(
    code: '069',
    id: '069',
    name: 'Tomato (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Fruits & Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 200.0,
    calories: 18.0,
    nutritions: {
      Nutrition.sugars: 3.2,
      Nutrition.fiber: 1.2,
    },
    minerals: {
      Minerals.potassium: 237.0,
      Minerals.calcium: 10.0,
    },
    vitamins: {
      Vetamins.c: 13.7,
      Vetamins.k: 7.9,
    },
  ),
  Food(
    code: '070',
    id: '070',
    name: 'Cucumber (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Fruits & Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 16.0,
    nutritions: {
      Nutrition.sugars: 3.6,
      Nutrition.fiber: 0.5,
    },
    minerals: {
      Minerals.potassium: 147.0,
      Minerals.manganese: 0.1,
    },
    vitamins: {
      Vetamins.k: 16.4,
      Vetamins.c: 2.8,
    },
  ),
  Food(
    code: '071',
    id: '071',
    name: 'Chicken Breast (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat',
    subcategory: 'Poultry',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 165.0,
    nutritions: {
      Nutrition.protein: 31.0,
      Nutrition.fats: 3.6,
    },
    minerals: {
      Minerals.phosphorus: 228.0,
      Minerals.selenium: 27.6,
    },
    vitamins: {
      Vetamins.b6: 0.6,
      Vetamins.b12: 0.3,
    },
  ),
  Food(
    code: '072',
    id: '072',
    name: 'Avocado (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 160.0,
    nutritions: {
      Nutrition.fats: 14.7,
      Nutrition.sugars: 0.7,
    },
    minerals: {
      Minerals.potassium: 485.0,
      Minerals.magnesium: 29.0,
    },
    vitamins: {
      Vetamins.k: 21.0,
      Vetamins.e: 2.1,
    },
  ),
  Food(
    code: '073',
    id: '073',
    name: 'Chia Seeds',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Nuts & Seeds',
    subcategory: 'Seeds',
    quantity: 30.0,
    avgDialyConsumption: 20.0,
    calories: 138.0,
    nutritions: {
      Nutrition.fiber: 10.6,
      Nutrition.protein: 4.7,
    },
    minerals: {
      Minerals.magnesium: 95.0,
      Minerals.calcium: 77.0,
    },
    vitamins: {
      Vetamins.b1: 0.3,
      Vetamins.e: 0.5,
    },
  ),
  Food(
    code: '074',
    id: '074',
    name: 'Coconut Oil',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Oils & Fats',
    subcategory: 'Vegetable Oils',
    quantity: 15.0,
    avgDialyConsumption: 10.0,
    calories: 135.0,
    nutritions: {
      Nutrition.fats: 15.0,
      Nutrition.saturatedFats: 13.0,
    },
    minerals: {
      Minerals.iron: 0.1,
      Minerals.sodium: 0.0,
    },
    vitamins: {
      Vetamins.e: 0.2,
    },
  ),
  Food(
    code: '075',
    id: '075',
    name: 'Broccoli (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Cruciferous Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 34.0,
    nutritions: {
      Nutrition.fiber: 2.6,
      Nutrition.protein: 2.8,
    },
    minerals: {
      Minerals.potassium: 316.0,
      Minerals.calcium: 47.0,
    },
    vitamins: {
      Vetamins.c: 89.2,
      Vetamins.k: 101.6,
    },
  ),
  Food(
    code: '076',
    id: '076',
    name: 'Lentils (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Legumes',
    subcategory: 'Pulses',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 116.0,
    nutritions: {
      Nutrition.protein: 9.0,
      Nutrition.fiber: 7.9,
    },
    minerals: {
      Minerals.iron: 3.3,
      Minerals.magnesium: 36.0,
    },
    vitamins: {
      Vetamins.b9: 179.0,
      Vetamins.b6: 0.2,
    },
  ),
  Food(
    code: '077',
    id: '077',
    name: 'Apple (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Pomes',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 52.0,
    nutritions: {
      Nutrition.fiber: 2.4,
      Nutrition.sugars: 10.4,
    },
    minerals: {
      Minerals.potassium: 107.0,
      Minerals.calcium: 6.0,
    },
    vitamins: {
      Vetamins.c: 4.6,
      Vetamins.k: 2.2,
    },
  ),
  Food(
    code: '078',
    id: '078',
    name: 'Peanut Butter (Unsweetened)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Snacks',
    subcategory: 'Spreads',
    quantity: 32.0,
    avgDialyConsumption: 15.0,
    calories: 188.0,
    nutritions: {
      Nutrition.fats: 16.0,
      Nutrition.protein: 8.0,
    },
    minerals: {
      Minerals.magnesium: 49.0,
      Minerals.phosphorus: 120.0,
    },
    vitamins: {
      Vetamins.e: 4.5,
    },
  ),
  Food(
    code: '079',
    id: '079',
    name: 'Cabbage (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Greens',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 25.0,
    nutritions: {
      Nutrition.fiber: 2.5,
      Nutrition.sugars: 3.2,
    },
    minerals: {
      Minerals.potassium: 170.0,
      Minerals.calcium: 40.0,
    },
    vitamins: {
      Vetamins.k: 76.0,
      Vetamins.c: 36.6,
    },
  ),
  Food(
    code: '080',
    id: '080',
    name: 'Mushrooms (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Fungi',
    quantity: 100.0,
    avgDialyConsumption: 100.0,
    calories: 22.0,
    nutritions: {
      Nutrition.fiber: 1.0,
      Nutrition.protein: 3.1,
    },
    minerals: {
      Minerals.potassium: 318.0,
      Minerals.selenium: 9.3,
    },
    vitamins: {
      Vetamins.d: 0.3,
      Vetamins.b2: 0.4,
    },
  ),
  Food(
    code: '081',
    id: '081',
    name: 'Carrot (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 41.0,
    nutritions: {
      Nutrition.sugars: 4.7,
      Nutrition.fiber: 2.8,
    },
    minerals: {
      Minerals.potassium: 320.0,
      Minerals.calcium: 33.0,
    },
    vitamins: {
      Vetamins.a: 835.0,
      Vetamins.k: 13.2,
    },
  ),
  Food(
    code: '082',
    id: '082',
    name: 'Salmon (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fish & Seafood',
    subcategory: 'Fatty Fish',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 208.0,
    nutritions: {
      Nutrition.protein: 22.0,
      Nutrition.fats: 13.0,
    },
    minerals: {
      Minerals.phosphorus: 204.0,
      Minerals.selenium: 38.0,
    },
    vitamins: {
      Vetamins.d: 16.5,
      Vetamins.b12: 3.0,
    },
  ),
  Food(
    code: '083',
    id: '083',
    name: 'Spinach (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Greens',
    quantity: 100.0,
    avgDialyConsumption: 100.0,
    calories: 23.0,
    nutritions: {
      Nutrition.sugars: 0.4,
      Nutrition.fiber: 2.2,
    },
    minerals: {
      Minerals.potassium: 558.0,
      Minerals.iron: 2.7,
    },
    vitamins: {
      Vetamins.k: 482.9,
      Vetamins.a: 469.0,
    },
  ),
  Food(
    code: '084',
    id: '084',
    name: 'Sweet Potato (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Root Vegetables',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 86.0,
    nutritions: {
      Nutrition.sugars: 4.2,
      Nutrition.fiber: 3.0,
    },
    minerals: {
      Minerals.potassium: 337.0,
      Minerals.manganese: 0.3,
    },
    vitamins: {
      Vetamins.a: 14187.0,
      Vetamins.c: 2.4,
    },
  ),
  Food(
    code: '085',
    id: '085',
    name: 'Tofu (Firm)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Legumes',
    subcategory: 'Soy Products',
    quantity: 100.0,
    avgDialyConsumption: 100.0,
    calories: 144.0,
    nutritions: {
      Nutrition.protein: 15.0,
      Nutrition.fats: 8.0,
    },
    minerals: {
      Minerals.iron: 5.4,
      Minerals.calcium: 253.0,
    },
    vitamins: {
      Vetamins.b9: 30.0,
    },
  ),
  Food(
    code: '086',
    id: '086',
    name: 'Kale (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Vegetables',
    subcategory: 'Leafy Greens',
    quantity: 100.0,
    avgDialyConsumption: 100.0,
    calories: 49.0,
    nutritions: {
      Nutrition.fiber: 4.1,
      Nutrition.protein: 4.3,
    },
    minerals: {
      Minerals.potassium: 491.0,
      Minerals.calcium: 150.0,
    },
    vitamins: {
      Vetamins.k: 704.0,
      Vetamins.a: 241.0,
    },
  ),
  Food(
    code: '087',
    id: '087',
    name: 'Pineapple (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Tropical Fruits',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 50.0,
    nutritions: {
      Nutrition.sugars: 9.9,
      Nutrition.fiber: 1.4,
    },
    minerals: {
      Minerals.potassium: 109.0,
      Minerals.manganese: 0.9,
    },
    vitamins: {
      Vetamins.c: 47.8,
      Vetamins.b6: 0.1,
    },
  ),
  Food(
    code: '088',
    id: '088',
    name: 'Lemon (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Citrus Fruits',
    quantity: 100.0,
    avgDialyConsumption: 50.0,
    calories: 29.0,
    nutritions: {
      Nutrition.sugars: 2.5,
      Nutrition.fiber: 2.8,
    },
    minerals: {
      Minerals.potassium: 138.0,
      Minerals.calcium: 26.0,
    },
    vitamins: {
      Vetamins.c: 53.0,
    },
  ),
  Food(
    code: '089',
    id: '089',
    name: 'Olives (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Stone Fruits',
    quantity: 100.0,
    avgDialyConsumption: 50.0,
    calories: 115.0,
    nutritions: {
      Nutrition.fats: 10.7,
      Nutrition.saturatedFats: 1.4,
    },
    minerals: {
      Minerals.potassium: 42.0,
      Minerals.calcium: 3.0,
    },
    vitamins: {
      Vetamins.e: 1.9,
    },
  ),
  Food(
    code: '090',
    id: '090',
    name: 'Pear (Raw)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Fruits',
    subcategory: 'Pomes',
    quantity: 100.0,
    avgDialyConsumption: 100.0,
    calories: 57.0,
    nutritions: {
      Nutrition.sugars: 9.8,
      Nutrition.fiber: 3.1,
    },
    minerals: {
      Minerals.potassium: 116.0,
      Minerals.calcium: 9.0,
    },
    vitamins: {
      Vetamins.c: 4.3,
    },
  ),
  Food(
    code: '091',
    id: '091',
    name: 'Chicken Breast (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat & Poultry',
    subcategory: 'Poultry',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 165.0,
    nutritions: {
      Nutrition.protein: 31.0,
      Nutrition.fats: 3.6,
    },
    minerals: {
      Minerals.potassium: 256.0,
      Minerals.phosphorus: 221.0,
    },
    vitamins: {
      Vetamins.b3: 11.5,
      Vetamins.b6: 0.6,
    },
  ),
  Food(
    code: '092',
    id: '092',
    name: 'Beef (Ground, Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat & Poultry',
    subcategory: 'Red Meat',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 250.0,
    nutritions: {
      Nutrition.protein: 26.0,
      Nutrition.fats: 17.0,
    },
    minerals: {
      Minerals.iron: 2.7,
      Minerals.zinc: 5.0,
    },
    vitamins: {
      Vetamins.b12: 2.6,
    },
  ),
  Food(
    code: '093',
    id: '093',
    name: 'Pork (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat & Poultry',
    subcategory: 'Pork',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 242.0,
    nutritions: {
      Nutrition.protein: 27.0,
      Nutrition.fats: 14.0,
    },
    minerals: {
      Minerals.potassium: 360.0,
      Minerals.phosphorus: 210.0,
    },
    vitamins: {
      Vetamins.b1: 0.8,
      Vetamins.b3: 4.2,
    },
  ),
  Food(
    code: '094',
    id: '094',
    name: 'Turkey (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat & Poultry',
    subcategory: 'Poultry',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 135.0,
    nutritions: {
      Nutrition.protein: 30.0,
      Nutrition.fats: 1.0,
    },
    minerals: {
      Minerals.potassium: 239.0,
      Minerals.phosphorus: 170.0,
    },
    vitamins: {
      Vetamins.b6: 0.8,
      Vetamins.b12: 1.1,
    },
  ),
  Food(
    code: '095',
    id: '095',
    name: 'Lamb (Cooked)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Meat & Poultry',
    subcategory: 'Red Meat',
    quantity: 100.0,
    avgDialyConsumption: 150.0,
    calories: 294.0,
    nutritions: {
      Nutrition.protein: 25.0,
      Nutrition.fats: 21.0,
    },
    minerals: {
      Minerals.iron: 2.1,
      Minerals.zinc: 4.4,
    },
    vitamins: {
      Vetamins.b12: 2.0,
    },
  ),
  Food(
    code: '096',
    id: '096',
    name: 'Egg (Boiled)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy & Eggs',
    subcategory: 'Eggs',
    quantity: 100.0,
    avgDialyConsumption: 2.0,
    calories: 155.0,
    nutritions: {
      Nutrition.protein: 13.0,
      Nutrition.fats: 11.0,
    },
    minerals: {
      Minerals.potassium: 126.0,
      Minerals.calcium: 56.0,
    },
    vitamins: {
      Vetamins.b2: 0.5,
      Vetamins.b12: 1.5,
    },
  ),
  Food(
    code: '097',
    id: '097',
    name: 'Cheese (Cheddar)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy & Eggs',
    subcategory: 'Cheese',
    quantity: 100.0,
    avgDialyConsumption: 50.0,
    calories: 402.0,
    nutritions: {
      Nutrition.protein: 25.0,
      Nutrition.fats: 33.0,
    },
    minerals: {
      Minerals.calcium: 721.0,
      Minerals.phosphorus: 500.0,
    },
    vitamins: {
      Vetamins.a: 200.0,
      Vetamins.d: 0.9,
    },
  ),
  Food(
    code: '098',
    id: '098',
    name: 'Yogurt (Plain)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy & Eggs',
    subcategory: 'Dairy',
    quantity: 100.0,
    avgDialyConsumption: 200.0,
    calories: 59.0,
    nutritions: {
      Nutrition.protein: 3.5,
      Nutrition.sugars: 4.7,
    },
    minerals: {
      Minerals.calcium: 110.0,
      Minerals.potassium: 155.0,
    },
    vitamins: {
      Vetamins.b2: 0.2,
      Vetamins.b12: 0.7,
    },
  ),
  Food(
    code: '099',
    id: '099',
    name: 'Milk (Whole)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy & Eggs',
    subcategory: 'Milk',
    quantity: 100.0,
    avgDialyConsumption: 200.0,
    calories: 61.0,
    nutritions: {
      Nutrition.protein: 3.2,
      Nutrition.fats: 3.3,
    },
    minerals: {
      Minerals.calcium: 113.0,
      Minerals.phosphorus: 91.0,
    },
    vitamins: {
      Vetamins.d: 0.2,
      Vetamins.a: 150.0,
    },
  ),
  Food(
    code: '100',
    id: '100',
    name: 'Butter (Salted)',
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/APPLE-GREEN.jpg',
    category: 'Dairy & Eggs',
    subcategory: 'Butter',
    quantity: 100.0,
    avgDialyConsumption: 20.0,
    calories: 717.0,
    nutritions: {
      Nutrition.fats: 81.0,
      Nutrition.saturatedFats: 51.0,
    },
    minerals: {
      Minerals.calcium: 24.0,
      Minerals.sodium: 303.0,
    },
    vitamins: {
      Vetamins.a: 684.0,
    },
  ),
].map((f) {
  const codes = [
    "6130003014606",
    "6130234000676",
    "6130413002545",
    "6130234001147",
    "6132508340150",
    "6132032900066"
  ];
  f.code = codes[Random().nextInt(codes.length)];
  return f;
}).toList();
