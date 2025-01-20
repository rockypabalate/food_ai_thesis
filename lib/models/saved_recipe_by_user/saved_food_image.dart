class SavedFoodImage {
  final String imageUrl;
  final String? caption;

  SavedFoodImage({
    required this.imageUrl,
    this.caption,
  });

  factory SavedFoodImage.fromJson(Map<String, dynamic> json) {
    return SavedFoodImage(
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
