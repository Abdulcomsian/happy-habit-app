import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
import 'package:happy_habit/modules/auth/services/auth_networking.dart';
import 'package:happy_habit/modules/profile_setup/services/avatar_attributes.dart';

import '../../../core/avatar/avatar_provider.dart';
import '../../../core/hive/hive_constants.dart';
import '../../../core/hive/hive_db_service.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/providers.dart';
import '../../navigation/navigation_provider.dart';
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
    if (response != null) {
      storeAuthToken();
      serviceLocator<AvatarProvider>().getCharacterElements();
    }
    return response != null;
  }

  Future<bool> refreshToken() async {
    if (_authToken == null) return false;

    final token = await _networkingLayer.refreshToken(_authToken!.token);
    _authToken = token;
    if (token != null) {
      storeAuthToken();
    } else {
      clearToken();
    }

    return token != null;
  }

  Future<bool> getUserProfile() async {
    final appUser = await _networkingLayer.getUserProfile();
    _appUser = appUser;
    if (appUser != null) {
      notifyListeners();
    } else {
      clearToken();
    }
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

  void clearToken() {
    _authToken = null;
    _hiveDBService.resetBox(boxKey: HiveConstants.kAuthToken);
  }

  Future<void> logout() async {
    clearToken();
    _appUser = null;
    _authToken = null;
    serviceLocator<NavigationProvider>().reset();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => Routes.rootNavigatorKey.currentContext!.goNamed(WelcomeScreen.id),
    );
  }

  Future<bool> sendOtp(int uid) async {
    return await _networkingLayer.sendOtp(uid);
  }

  Future<bool> verifyOtp(int uid, int otp) async {
    return await _networkingLayer.verifyOtp(uid, otp);
  }

  void updateUser({
    String? name,
    String? email,
    // String? gender,
    String? imageUrl,
    String? username,
    bool? areGoalsReady,
    AvatarAttributes? avatarAttributes,
  }) {
    if (_appUser != null) {
      _appUser = _appUser!
        ..name = name ?? _appUser!.name
        ..email = email ?? _appUser!.email
      // ..gender = gender ?? _appUser!.gender
        ..username = username ?? _appUser!.username
        ..imageUrl = imageUrl ?? _appUser!.imageUrl
        ..areGoalsReady = areGoalsReady ?? _appUser!.areGoalsReady
        ..avatarAttributes = avatarAttributes ?? _appUser!.avatarAttributes;
      notifyListeners();
    }
  }
}
