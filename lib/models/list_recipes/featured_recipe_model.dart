class FeaturedRecipe {
  final int id;
  final String foodName;
  final String description;
  final String? servingSize;
  final String? totalCookTime;
  final String? difficulty;
  final String? category;
  final int views;
  final int likes;
  final String? preparationTips;
  final String? nutritionalParagraph;
  final String? author;
  final String recipeFeatured;
  final List<ImageInfo> images;

  FeaturedRecipe({
    required this.id,
    required this.foodName,
    required this.description,
    this.servingSize,
    this.totalCookTime,
    this.difficulty,
    this.category,
    required this.views,
    required this.likes,
    this.preparationTips,
    this.nutritionalParagraph,
    this.author,
    required this.recipeFeatured,
    required this.images,
  });

  factory FeaturedRecipe.fromJson(Map<String, dynamic> json) {
    return FeaturedRecipe(
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
      recipeFeatured: json['recipe_featured'],
      images: (json['images'] as List<dynamic>?)
              ?.map((image) => ImageInfo.fromJson(image))
              .toList() ??
          [],
    );
  }
}

class ImageInfo {
  final String imageUrl;
  final String? caption;

  ImageInfo({
    required this.imageUrl,
    this.caption,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      imageUrl: json['image_url'],
      caption: json['caption'],
    );
  }
}
