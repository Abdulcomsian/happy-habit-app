import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class RouteHelper {
  static Future<String?> onAppStartup(BuildContext context, GoRouterState state) async {
    FlutterNativeSplash.remove();
    return null;
  }
}
