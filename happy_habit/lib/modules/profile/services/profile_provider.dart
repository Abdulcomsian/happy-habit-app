import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  static final ProfileProvider _instance = ProfileProvider._internal();

  factory ProfileProvider() => _instance;

  ProfileProvider._internal();

  // Your methods and properties here

  Future<bool> changePassword({required String oldPassword, required String newPassword}) {
    return Future.value(false);
  }
}
