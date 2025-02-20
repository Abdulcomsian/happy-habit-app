class Goal {
  final int id;
  final Duration time;
  final String title, image;

  const Goal({
    required this.id,
    required this.time,
    required this.title,
    required this.image,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      title: json['name'],
      image: json['image'],
      time: Duration(minutes: json['minutes']),
    );
  }
}