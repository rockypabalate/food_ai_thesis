class User {
  final String email;
  final String? password;
  final String? username;
  final String? profileImage;

  User({
    required this.email,
    this.password,
    this.username,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        username: json['username'],
        profileImage: json['profile_image'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'profile_image': profileImage,
      };

  User copyWith({
    String? email,
    String? password,
    String? username,
    String? profileImage,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
