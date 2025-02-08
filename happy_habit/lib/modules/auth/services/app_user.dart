class AppUser {
  final int id;
  bool areGoalsReady;
  String name, email;
  String? gender, username, imageUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.imageUrl,
    required this.username,
    required this.areGoalsReady,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      imageUrl: json['imageUrl'],
      username: json['username'],
      areGoalsReady: json['areGoalsReady'] ?? false,
    );
  }

  bool get isMaleCharacter => gender == 'male';
}
