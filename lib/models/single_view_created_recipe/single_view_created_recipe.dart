class SingleDisplayRecipe {
  final String id; // ✅ Ensure ID is always stored as a string
  final String foodName;
  final String description;
  final int servings;
  final String category;
  final List<String> ingredients;
  final List<String> quantities;
  final List<String> instructions;
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
    required this.totalCookTime,
    required this.difficulty,
    required this.preparationTips,
    required this.nutritionalParagraph,
    required this.images,
  });

 factory SingleDisplayRecipe.fromJson(Map<String, dynamic> json) {
  List<Map<String, dynamic>> parsedIngredients =
      (json['ingredients'] as List<dynamic>? ?? [])
          .map((e) => e as Map<String, dynamic>)
          .toList();

  return SingleDisplayRecipe(
    id: json['id'].toString(),
    foodName: json['food_name'] ?? '',
    description: json['description'] ?? '',
    servings: json['servings'] ?? 0,
    category: json['category'] ?? '',
    ingredients: parsedIngredients.map((e) => e['name'].toString()).toList(),
    quantities: parsedIngredients.map((e) => e['quantity'].toString()).toList(),
    instructions: (json['instructions'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList(),
    totalCookTime: json['total_cook_time'] ?? '',
    difficulty: json['difficulty'] ?? '',
    preparationTips: json['preparation_tips'] ?? '',
    nutritionalParagraph: json['nutritional_paragraph'] ?? '',
    images: (json['images'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList(),
  );
}

}
