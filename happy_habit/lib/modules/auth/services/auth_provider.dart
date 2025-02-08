import 'package:flutter/material.dart';
import 'package:happy_habit/modules/auth/services/auth_networking.dart';

import '../../../core/hive/hive_constants.dart';
import '../../../core/hive/hive_db_service.dart';
import 'app_user.dart';
import 'auth_token.dart';

class AuthProvider extends ChangeNotifier {
  static final AuthProvider _instance = AuthProvider._internal();

  factory AuthProvider() => _instance;

  AuthProvider._internal();

  // Your methods and properties here
  final _networkingLayer = AuthNetworking();
  final HiveDBService _hiveDBService = HiveDBService();

  AppUser? get appUser => _appUser;
  AppUser? _appUser;

  AuthToken? get authToken => _authToken;
  AuthToken? _authToken;

  Future<int?> signup(Map<String, dynamic> body) async {
    return await _networkingLayer.signup(body);
  }

  Future<int?> forgotPassword(String email) async {
    return await _networkingLayer.forgotPassword(email);
  }

  Future<bool> updatePassword(int uid, String password) async {
    return await _networkingLayer.updatePassword(uid, password);
  }

  Future<bool> login(String email, String password) async {
    final response = await _networkingLayer.login(email, password);
    _appUser = response?.appUser;
    _authToken = response?.authToken;
    if (response != null) storeAuthToken();
    return response != null;
  }

  Future<bool> getUserProfile() async {
    final appUser = await _networkingLayer.getUserProfile();
    _appUser = appUser;
    if (appUser != null) notifyListeners();
    return appUser != null;
  }

  /// checks if [AuthToken] exists in Hive
  Future<bool> isUserLoggedIn() async {
    var authToken = await _hiveDBService.loadData(
      boxKey: HiveConstants.kAuthToken,
      valueKey: HiveConstants.kAuthToken,
    ) as AuthToken?;

    if (authToken != null) {
      _authToken = authToken;

      return true;
    } else {
      return false;
    }
  }

  /// loads [AuthToken] object in [AuthServicesProvider] and stores it in Hive box authToken
  void storeAuthToken() {
    // store _authToken in Hive
    _hiveDBService.storeData(
      object: _authToken!,
      boxKey: HiveConstants.kAuthToken,
      valueKey: HiveConstants.kAuthToken,
    );
  }

  Future<bool> saveCharacter(String gender) async {
    _appUser?.gender = gender;
    notifyListeners();
    return true;
  }

  Future<bool> getRefreshToken() async {
    return false;
  }

  Future<void> logout() async {}

  Future<bool> sendOtp(int uid) async {
    return await _networkingLayer.sendOtp(uid);
  }

  Future<bool> verifyOtp(int uid, int otp) async {
    return await _networkingLayer.verifyOtp(uid, otp);
  }
}
