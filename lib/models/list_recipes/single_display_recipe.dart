class FoodInfoById {
  final int id;
  final String foodName;
  final String description;
  final String servingSize;
  final String? totalCookTime;
  final String? difficulty;
  final String? category;
  final int views;
  final int likes;
  final String? preparationTips;
  final String? nutritionalParagraph;
  final String? author;
  final String recipeFeatured;
  final String? link; // ✅ Added link field
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final List<String> nutritionalContent;
  final List<RecipeImage> images;

  FoodInfoById({
    required this.id,
    required this.foodName,
    required this.description,
    required this.servingSize,
    this.totalCookTime,
    this.difficulty,
    this.category,
    this.views = 0,
    this.likes = 0,
    this.preparationTips,
    this.nutritionalParagraph,
    this.author,
    this.recipeFeatured = '0',
    this.link, // ✅ Include in constructor
    required this.ingredients,
    required this.instructions,
    required this.nutritionalContent,
    required this.images,
  });

  factory FoodInfoById.fromJson(Map<String, dynamic> json) {
    return FoodInfoById(
      id: json['id'] ?? 0,
      foodName: json['food_name'] ?? '',
      description: json['description'] ?? '',
      servingSize: json['serving_size'] ?? '',
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      category: json['category'],
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      preparationTips: json['preparation_tips'],
      nutritionalParagraph: json['nutritional_paragraph'],
      author: json['author'],
      recipeFeatured: json['recipe_featured'] ?? '0',
      link: json['link'], // ✅ Parse from JSON
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e))
              .toList() ??
          [],
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      nutritionalContent: (json['nutritional_content'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      images: (json['images'] as List<dynamic>?)
              ?.map((img) => RecipeImage.fromJson(img))
              .toList() ??
          [],
    );
  }
}

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
    );
  }
}

class RecipeImage {
  final String imageUrl;
  final String? caption;

  RecipeImage({
    required this.imageUrl,
    this.caption,
  });

  factory RecipeImage.fromJson(Map<String, dynamic> json) {
    return RecipeImage(
      imageUrl: json['image_url'] ?? '',
      caption: json['caption'],
    );
  }
}
