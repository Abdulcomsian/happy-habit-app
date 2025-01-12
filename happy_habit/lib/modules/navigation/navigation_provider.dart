import 'package:flutter/material.dart';

import '../../core/hive/hive_constants.dart';
import '../../core/hive/hive_db_service.dart';
import '../../core/services/logger.dart';

class NavigationProvider extends ChangeNotifier {
  static final NavigationProvider _instance = NavigationProvider._internal();

  factory NavigationProvider() => _instance;

  NavigationProvider._internal();

  // Your methods and properties here
  final HiveDBService _hiveDBService = HiveDBService();

  int get currentIndex => _currentIndex;
  int _currentIndex = 2;

  bool get isFirstLaunch => _isFirstLaunch;
  bool _isFirstLaunch = true;

  void changeIndex(int i) {
    if (_currentIndex == i) return;
    _currentIndex = i;
    notifyListeners();
  }

  Future<bool> onWillPop(didPop, result) async {
    if (_currentIndex > 0) {
      changeIndex(0);

      return false;
    } else {
      return true;
    }
  }

  Future<bool> loadIsFirstLaunch() async {
    bool result = await _hiveDBService.loadData(
          boxKey: HiveConstants.kAppSettings,
          valueKey: HiveConstants.kIsFirstLaunch,
        ) as bool? ??
        true;

    _isFirstLaunch = result;
    return result;
  }

  Future<void> storeIsFirstLaunch() async {
    await _hiveDBService.storeData(
      object: false,
      boxKey: HiveConstants.kAppSettings,
      valueKey: HiveConstants.kIsFirstLaunch,
    );
    Logger.logInfo('kIsFirstLaunch stored as: ');
  }
}
