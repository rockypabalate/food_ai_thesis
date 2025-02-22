class SingleDisplayRecipe {
  final String id; // ✅ Ensure ID is always stored as a string
  final String foodName;
  final String description;
  final int servings;
  final String category;
  final List<String> ingredients;
  final List<String> quantities;
  final List<String> instructions;
  final List<NutritionalContent> nutritionalContent;
  final String totalCookTime;
  final String difficulty;
  final String preparationTips;
  final String nutritionalParagraph;
  final List<String> images;

  SingleDisplayRecipe({
    required this.id, // ✅ Include in constructor
    required this.foodName,
    required this.description,
    required this.servings,
    required this.category,
    required this.ingredients,
    required this.quantities,
    required this.instructions,
    required this.nutritionalContent,
    required this.totalCookTime,
    required this.difficulty,
    required this.preparationTips,
    required this.nutritionalParagraph,
    required this.images,
  });

  factory SingleDisplayRecipe.fromJson(Map<String, dynamic> json) {
    return SingleDisplayRecipe(
      id: json['id'].toString(), // ✅ Convert ID to string to avoid type errors
      foodName: json['food_name'] ?? '',
      description: json['description'] ?? '',
      servings: json['servings'] ?? 0,
      category: json['category'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      quantities: List<String>.from(json['quantities'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      nutritionalContent: (json['nutritional_content'] as List<dynamic>? ?? [])
          .map((e) => NutritionalContent.fromJson(e))
          .toList(),
      totalCookTime: json['total_cook_time'] ?? '',
      difficulty: json['difficulty'] ?? '',
      preparationTips: json['preparation_tips'] ?? '',
      nutritionalParagraph: json['nutritional_paragraph'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }
}


class NutritionalContent {
  final String name;
  final String amount;

  NutritionalContent({
    required this.name,
    required this.amount,
  });

  factory NutritionalContent.fromJson(Map<String, dynamic> json) {
    return NutritionalContent(
      name: json['name'] ?? '',
      amount: json['amount'] ?? '',
    );
  }
}
