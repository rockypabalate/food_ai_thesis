class PopularRecipe {
  final int id;
  final String foodName;
  final String description;
  final String? servingSize;
  final String? totalCookTime;
  final String? difficulty;
  final String? category;
  final int views;
  final int likes;
  final int saves;
  final String? preparationTips;
  final String? nutritionalParagraph;
  final String? author;
  final bool recipeFeatured; // ✅ Change to bool
  final List<PopularRecipeImage> images;

  PopularRecipe({
    required this.id,
    required this.foodName,
    required this.description,
    this.servingSize,
    this.totalCookTime,
    this.difficulty,
    this.category,
    required this.views,
    required this.likes,
    required this.saves,
    this.preparationTips,
    this.nutritionalParagraph,
    this.author,
    required this.recipeFeatured, // ✅ Now it accepts bool values
    required this.images,
  });

  factory PopularRecipe.fromJson(Map<String, dynamic> json) {
    return PopularRecipe(
      id: json['id'],
      foodName: json['food_name'],
      description: json['description'],
      servingSize: json['serving_size'],
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      category: json['category'],
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      saves: json['saves'] ?? 0,
      preparationTips: json['preparation_tips'],
      nutritionalParagraph: json['nutritional_paragraph'],
      author: json['author'],
      recipeFeatured: json['recipe_featured'] ?? false, // ✅ Ensure it's a bool
      images: (json['images'] as List<dynamic>?)
              ?.map((image) => PopularRecipeImage.fromJson(image))
              .toList() ??
          [],
    );
  }
}

// Independent Image Model
class PopularRecipeImage {
  final String imageUrl;
  final String? caption;

  PopularRecipeImage({
    required this.imageUrl,
    this.caption,
  });

  factory PopularRecipeImage.fromJson(Map<String, dynamic> json) {
    return PopularRecipeImage(
      imageUrl: json['image_url'],
      caption: json['caption'],
    );
  }
}
