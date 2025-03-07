class Activity {
  final int id;
  final DateTime timestamp;
  final String description;

  const Activity({
    required this.id,
    required this.timestamp,
    required this.description,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now()),
    );
  }
}
