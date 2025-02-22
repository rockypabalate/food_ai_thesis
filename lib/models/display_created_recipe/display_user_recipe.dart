import 'dart:convert';

class UserRecipe {
  final int recipeId;
  final String foodName;
  final String description;
  final String totalCookTime;
  final String difficulty;
  final List<String> images;

  UserRecipe({
    required this.recipeId,
    required this.foodName,
    required this.description,
    required this.totalCookTime,
    required this.difficulty,
    required this.images,
  });

  // Convert JSON to UserRecipe object
  factory UserRecipe.fromJson(Map<String, dynamic> json) {
    return UserRecipe(
      recipeId: json['recipe_id'],
      foodName: json['food_name'],
      description: json['description'],
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  // Convert UserRecipe object to JSON
  Map<String, dynamic> toJson() {
    return {
      "recipe_id": recipeId,
      "food_name": foodName,
      "description": description,
      "total_cook_time": totalCookTime,
      "difficulty": difficulty,
      "images": images,
    };
  }

  // Convert JSON list to List<UserRecipe>
  static List<UserRecipe> fromJsonList(String str) {
    final jsonData = json.decode(str);
    return List<UserRecipe>.from(jsonData.map((x) => UserRecipe.fromJson(x)));
  }
}
