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
  final List<NutritionalContent> nutritionalContent;
  final String totalCookTime;
  final String difficulty;
  final String preparationTips;
  final String nutritionalParagraph;

  Recipe({
    required this.id,
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
      nutritionalContent: (json['nutritional_content'] as List)
          .map((e) => NutritionalContent.fromJson(e))
          .toList(),
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      preparationTips: json['preparation_tips'],
      nutritionalParagraph: json['nutritional_paragraph'],
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
      'nutritional_content':
          nutritionalContent.map((e) => e.toJson()).toList(),
      'total_cook_time': totalCookTime,
      'difficulty': difficulty,
      'preparation_tips': preparationTips,
      'nutritional_paragraph': nutritionalParagraph,
    };
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
      name: json['name'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
    };
  }
}
