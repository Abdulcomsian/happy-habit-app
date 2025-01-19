import 'package:flutter/material.dart';

class ProfileSetupProvider extends ChangeNotifier {
  static final ProfileSetupProvider _instance = ProfileSetupProvider._internal();

  factory ProfileSetupProvider() => _instance;

  ProfileSetupProvider._internal();

  // Your methods and properties here
  Future<bool> validateUsername(String username) async {

    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }

  Future<bool> setUsername(String username) async {
    await Future.delayed(Duration(milliseconds: 500));
    return true;
  }
}
