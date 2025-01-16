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
      title: "Sleep",
      duration: Duration(hours: 12),
      color: Color(0xFF80E335),
    ),
    Activity(
      title: "Productivity",
      duration: Duration(hours: 8),
      color: Color(0xFFEF1152),
    ),
    Activity(
      title: "Focus",
      duration: Duration(hours: 4),
      color: Color(0xFFF72805),
    ),
    Activity(
      title: "Screen",
      duration: Duration(hours: 2),
      color: Color(0xFFF6900D),
    ),
    Activity(
      title: "Workout",
      duration: Duration(hours: 1, minutes: 15),
      color: Color(0xFFE8EB03),
    ),
  ];
}
