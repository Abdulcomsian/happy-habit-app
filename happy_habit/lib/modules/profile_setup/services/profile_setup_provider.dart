import 'package:flutter/material.dart';
import 'package:happy_habit/core/avatar/avatar_provider.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/profile_setup/services/avatar_attributes.dart';
import 'package:rive/rive.dart';

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
    final isSetup = await _networkingLayer.setUsername(uid, username);
    if (isSetup) {
      serviceLocator<AuthProvider>().updateUser(username: username);
    }
    return isSetup;
  }

  Future<void> getGoals() async {
    _goals = await _networkingLayer.getGoals() ?? [];
    if (_goals.isNotEmpty) notifyListeners();
  }

  Future<bool> setGoals() async {
    Map<String, dynamic> payload = {};
    for (final x in _goals) {
      payload['${x.id}'] = x.time.inMinutes;
    }
    final isSetup = await _networkingLayer.setGoals(payload);
    if (isSetup) {
      serviceLocator<AuthProvider>().updateUser(areGoalsReady: true);
    }
    return isSetup;
  }

  Future<bool> saveCharacter(Artboard artboard, AvatarAttributes attributes) async {
    final prov = serviceLocator<AuthProvider>();
    final avatarProv = serviceLocator<AvatarProvider>();

    final isSetup = await _networkingLayer.setAvatar(attributes.toJson());
    if (isSetup) {
      prov.updateUser(avatarAttributes: attributes);
      avatarProv.initializeUserArtboard(artboard: artboard);
    }
    return isSetup;
  }
}
