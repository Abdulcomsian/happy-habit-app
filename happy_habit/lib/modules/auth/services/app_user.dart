class AppUser {
  final int id;
  final String avatar;
  final String name, email, username, imageUrl;

  const AppUser({
    required this.id,
    this.username = '',
    required this.name,
    required this.email,
    required this.avatar,
    required this.imageUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      username: json['username'] ?? '',
    );
  }

  bool get isProfileSetup => username.isNotEmpty;
}
