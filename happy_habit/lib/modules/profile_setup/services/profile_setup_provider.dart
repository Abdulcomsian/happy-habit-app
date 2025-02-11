import 'package:flutter/material.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';

import 'goal.dart';
import 'profile_setup_networking.dart';

class ProfileSetupProvider extends ChangeNotifier {
  static final ProfileSetupProvider _instance = ProfileSetupProvider._internal();

  factory ProfileSetupProvider() => _instance;

  ProfileSetupProvider._internal();

  // Your methods and properties here
  final _networkingLayer = ProfileSetupNetworking();

  List<Goal> get goals => _goals;
  List<Goal> _goals = [];

  Future<bool> validateUsername(String username) async {
    return await _networkingLayer.validateUsername(username);
  }

  Future<bool> setUsername(String username) async {
    final uid = serviceLocator<AuthProvider>().appUser!.id;
    return await _networkingLayer.setUsername(uid, username);
  }

  Future<void> getGoals() async {
    final goals = await _networkingLayer.getGoals();
    if (goals != null) {
      _goals = goals;
      notifyListeners();
    }
  }
}
