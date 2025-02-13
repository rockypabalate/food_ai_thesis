class FoodInformation {
  final int id;
  final String foodName;
  final String description;
  final String? category; // Make category nullable with String?

  FoodInformation({
    required this.id,
    required this.foodName,
    required this.description,
    this.category, // Remove required for optional fields
  });

  factory FoodInformation.fromJson(Map<String, dynamic> json) {
    return FoodInformation(
      id: json['id'] as int,
      foodName: json['food_name'] as String,
      description: json['description'] as String,
      category: json['category'] as String?, // Use null safety
    );
  }
}
