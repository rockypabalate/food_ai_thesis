class FoodInformation {
  final int id;
  final String foodName;
  final String description;

  FoodInformation(
      {required this.foodName, required this.id, required this.description});

  factory FoodInformation.fromJson(Map<String, dynamic> json) {
    return FoodInformation(
      id: json['id'],
      foodName: json['food_name'],
      description: json['description'],
    );
  }
}
