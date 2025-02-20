import 'dart:ui';

import 'package:happy_habit/core/extensions/color_extensions.dart';

class Goal {
  final int id;
  final Color color;
  final Duration time;
  final String title, image;

  const Goal({
    required this.id,
    required this.time,
    required this.color,
    required this.title,
    required this.image,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
// Check if 'color' exists in the json, otherwise apply default color
    final color = json['color'] != null
        ? (json['color'] as String).toColor()  // Convert color from string
        : _color(json['name']);  // Apply default color based on the title (name)


    return Goal(
      color: color,
      id: json['id'],
      title: json['name'],
      image: json['image'],
      time: Duration(minutes: json['minutes']),
    );
  }

  // Helper method to get the default color based on the goal's title
  static Color _color(String title) {
    switch (title.toLowerCase()) {
      case 'sleep time':
        return Color(0xffFF5858);
      case 'workout':
        return Color(0xffBC58FF);
      case 'screen time':
        return Color(0xffFF8558);
      case 'focus time':
      default:
        return Color(0xff00CF0E);
    }
  }
}