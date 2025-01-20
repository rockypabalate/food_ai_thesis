class SavedFood {
  final int id;
  final String foodName;
  final int likes;
  final int views;
  final String? totalCookTime;
  final String? difficulty;
  final String? author;
  final FoodImage? image;

  SavedFood({
    required this.id,
    required this.foodName,
    required this.likes,
    required this.views,
    this.totalCookTime,
    this.difficulty,
    this.author,
    this.image,
  });

  factory SavedFood.fromJson(Map<String, dynamic> json) {
    return SavedFood(
      id: json['id'],
      foodName: json['food_name'],
      likes: json['likes'],
      views: json['views'],
      totalCookTime: json['total_cook_time'],
      difficulty: json['difficulty'],
      author: json['author'],
      image: json['image'] != null ? FoodImage.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_name': foodName,
      'likes': likes,
      'views': views,
      'total_cook_time': totalCookTime,
      'difficulty': difficulty,
      'author': author,
      'image': image?.toJson(),
    };
  }
}

class FoodImage {
  final String imageUrl;
  final String? caption;

  FoodImage({
    required this.imageUrl,
    this.caption,
  });

  factory FoodImage.fromJson(Map<String, dynamic> json) {
    return FoodImage(
      imageUrl: json['image_url'],
      caption: json['caption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'caption': caption,
    };
  }
}
