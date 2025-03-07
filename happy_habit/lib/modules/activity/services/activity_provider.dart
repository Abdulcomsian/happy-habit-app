import 'package:flutter/material.dart';
import 'package:happy_habit/modules/activity/services/activity_networking.dart';

import '../shared/models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  static final ActivityProvider _instance = ActivityProvider._internal();

  factory ActivityProvider() => _instance;

  ActivityProvider._internal();

  // Your methods and properties here
  final _networkingLayer = ActivityNetworking();

  bool get isLoading => _isLoading;
  bool _isLoading = true;

  List<Activity> get activities => _activities;
  List<Activity> _activities = [];

  Future<void> getActivities() async {
    final activities = await _networkingLayer.getActivities();
    if (activities != null) {
      _activities = List.from(activities);
    }

    _isLoading = false;
    notifyListeners();
  }
}
