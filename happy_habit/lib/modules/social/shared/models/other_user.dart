class OtherUser {
  final int id, xp;
  final String name, imageUrl;

  const OtherUser({
    required this.id,
    required this.xp,
    required this.name,
    required this.imageUrl,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) {
    return OtherUser(
      id: json['id'],
      xp: json['xp'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
