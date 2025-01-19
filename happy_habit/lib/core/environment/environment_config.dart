import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum EnvironmentType { staging, production }

class Environment {
  static const String _androidProdPackage = 'com.happyHabit.android';
  static const String _androidStagingPackage = 'com.happyHabit.android.stg';
  static const String _iosProdPackage = 'com.happyHabit.ios';
  static const String _iosStagingPackage = 'com.happyHabit.ios.stg';

  static bool _isProduction = true;

  static bool _isStaging = true;

  Future<String> getFileNameFromEnvironment() async {
    final current = await _determineBuildEnvironment();

    _isProduction = (current == EnvironmentType.production);

    _isStaging = (current == EnvironmentType.staging);

    return _isProduction
        ? '.env.production'
        : _isStaging
            ? '.env.staging'
            : '.env.development';
  }

  Future<EnvironmentType> _determineBuildEnvironment() async {
    final packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      return packageInfo.packageName == _androidProdPackage
          ? EnvironmentType.production
          : EnvironmentType.staging;
    } else if (Platform.isIOS) {
      return packageInfo.packageName == _iosProdPackage
          ? EnvironmentType.production
          : EnvironmentType.staging;
    }

    // Default to staging for other platforms
    return EnvironmentType.staging;
  }

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  static bool get isProduction => _isProduction;
}
