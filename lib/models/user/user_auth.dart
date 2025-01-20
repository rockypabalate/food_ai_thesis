class User {
  final String email;
  final String? password;
  final String? username;
  final String? profileImage;
  final String? address;
  final String? role;

  User({
    required this.email,
    this.password,
    this.username,
    this.profileImage,
    this.address,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        username: json['username'],
        profileImage: json['profile_image'],
        address: json['address'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'profile_image': profileImage,
        'address': address,
        'role': role,
      };

  User copyWith({
    String? email,
    String? password,
    String? username,
    String? profileImage,
    String? bio,
    String? favoriteRecipe,
    String? dietaryPreference,
    String? address,
    String? role,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      profileImage: profileImage ?? this.profileImage,
      address: address ?? this.address,
      role: role ?? this.role,
    );
  }
}
