class RecipeResponse {
  final String message;
  final Recipe recipe;

  RecipeResponse({
    required this.message,
    required this.recipe,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(
      message: json['message'],
      recipe: Recipe.fromJson(json['recipe']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'recipe': recipe.toJson(),
    };
  }
}

class Recipe {
  final int id;
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
  final String? nutritionalParagraph; // Made optional

  Recipe({
    required this.id,
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
    this.nutritionalParagraph, // Optional
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      foodName: json['food_name'],
      description: json['description'],
      servings: json['servings'],
      category: json['category'],
      ingredients: List<String>.from(json['ingredients']),
      quantities: List<String>.from(json['quantities']),
      instructions: List<String>.from(json['instructions']),
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      preparationTips: json['preparation_tips'],
      nutritionalParagraph: json['nutritional_paragraph'], // Optional
    );
  }

Map<String, dynamic> toJson() {
  return {
    'id': id,
    'food_name': foodName,
    'description': description,
    'servings': servings,
    'category': category,
    'ingredients': ingredients,
    'quantities': quantities,
    'instructions': instructions,
    'total_cook_time': totalCookTime,
    'difficulty': difficulty,
    'preparation_tips': preparationTips,
    if (nutritionalParagraph != null) 
      'nutritional_paragraph': nutritionalParagraph,
  };
}

}
