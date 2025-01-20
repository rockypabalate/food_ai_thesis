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
  final List<String> ingredients;
  final List<String> ingredientQuantities;
  final List<String> instructions;
  final List<String> nutritionalContent;
  final List<Image> images;

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
    required this.ingredients,
    required this.ingredientQuantities,
    required this.instructions,
    required this.nutritionalContent,
    required this.images,
  });

  factory FoodInfoById.fromJson(Map<String, dynamic> json) {
    return FoodInfoById(
      id: json['id'],
      foodName: json['food_name'],
      description: json['description'],
      servingSize: json['serving_size'],
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      category: json['category'],
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      preparationTips: json['preparation_tips'],
      nutritionalParagraph: json['nutritional_paragraph'],
      author: json['author'],
      recipeFeatured: json['recipe_featured'] ?? '0',
      ingredients: List<String>.from(json['ingredients']),
      ingredientQuantities: List<String>.from(json['ingredient_quantities']),
      instructions: List<String>.from(json['instructions']),
      nutritionalContent: List<String>.from(json['nutritional_content']),
      images:
          List<Image>.from(json['images'].map((img) => Image.fromJson(img))),
    );
  }
}

class Image {
  final String imageUrl;
  final String? caption;

  Image({
    required this.imageUrl,
    this.caption,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      imageUrl: json['image_url'],
      caption: json['caption'],
    );
  }
}
