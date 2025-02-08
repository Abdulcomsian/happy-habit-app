import 'package:flutter/material.dart';

class Activity {
  final String title;
  final Duration duration;
  final Color color;

  Activity({
    required this.title,
    required this.duration,
    required this.color,
  });

  static List<Activity> activities = [
    Activity(
      title: "sleep",
      duration: Duration(hours: 2),
      color: Color(0xFF80E335),
    ),
    Activity(
      title: "focus",
      duration: Duration(hours: 2),
      color: Color(0xFFF72805),
    ),
    Activity(
      title: "screen",
      duration: Duration(hours: 2),
      color: Color(0xFFF6900D),
    ),
    Activity(
      title: "workout",
      duration: Duration(hours: 2),
      color: Color(0xFFE8EB03),
    ),
  ];
}
