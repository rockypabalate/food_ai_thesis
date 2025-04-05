class FoodInfo {
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
  final int recipeFeatured;
  final List<String> imageUrls; // Changed from a single image to a list

  FoodInfo({
    required this.id,
    required this.foodName,
    required this.description,
    this.servingSize,
    this.totalCookTime,
    this.difficulty,
    this.category,
    this.views = 0,
    this.likes = 0,
    this.preparationTips,
    this.nutritionalParagraph,
    this.author,
    this.recipeFeatured = 0,
    this.imageUrls = const [], // Default empty list
  });

  // Factory method for JSON deserialization
  factory FoodInfo.fromJson(Map<String, dynamic> json) {
    return FoodInfo(
      id: json['id'] ?? 0,
      foodName: json['food_name'] ?? '',
      description: json['description'] ?? '',
      servingSize: json['serving_size'],
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      category: json['category'],
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      preparationTips: json['preparation_tips'],
      nutritionalParagraph: json['nutritional_paragraph'],
      author: json['author'],
      recipeFeatured: _parseRecipeFeatured(json['recipe_featured']),
      imageUrls: (json['images'] as List<dynamic>?)
              ?.map((image) => image['image_url'] as String)
              .toList() ??
          [],
    );
  }

  // Helper method to safely parse recipeFeatured to an integer
  static int _parseRecipeFeatured(dynamic value) {
    if (value == null) return 0;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is int) return value;
    return 0; // Default to 0 for any unexpected types
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_name': foodName,
      'description': description,
      'serving_size': servingSize,
      'total_cook_time': totalCookTime,
      'difficulty': difficulty,
      'category': category,
      'views': views,
      'likes': likes,
      'preparation_tips': preparationTips,
      'nutritional_paragraph': nutritionalParagraph,
      'author': author,
      'recipe_featured': recipeFeatured,
      'images': imageUrls.map((url) => {'image_url': url}).toList(),
    };
  }
}
