import 'package:flutter/material.dart';

import '../../../core/hive/hive_constants.dart';
import '../../../core/hive/hive_db_service.dart';
import 'auth_token.dart';

class AuthProvider extends ChangeNotifier {
  static final AuthProvider _instance = AuthProvider._internal();

  factory AuthProvider() => _instance;

  AuthProvider._internal();

  // Your methods and properties here
  final HiveDBService _hiveDBService = HiveDBService();

  AuthToken? get authToken => _authToken;
  AuthToken? _authToken;

  /// checks if [AuthToken] exists in Hive
  Future<bool> isUserLoggedIn() async {
    var authToken = await _hiveDBService.loadData(
      boxKey: HiveConstants.kAuthToken,
      valueKey: HiveConstants.kAuthToken,
    ) as AuthToken?;

    if (authToken != null) {
      setAuthToken(authToken, updateInHive: false);

      return true;
    } else {
      return false;
    }
  }

  /// loads [AuthToken] object in [AuthServicesProvider] and stores it in Hive box authToken
  setAuthToken(AuthToken authToken, {bool updateInHive = true}) {
    _authToken = authToken;

    if (updateInHive) {
      // store _authToken in Hive
      _hiveDBService.storeData(
        object: _authToken!,
        boxKey: HiveConstants.kAuthToken,
        valueKey: HiveConstants.kAuthToken,
      );
    }
  }

  Future<bool> generateOTP(String email) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }
}
