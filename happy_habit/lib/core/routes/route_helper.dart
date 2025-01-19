import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/profile_setup/screens/username_screen.dart';

import '../services/providers.dart';

class RouteHelper {
  static Future<String?> onAppStartup(BuildContext context, GoRouterState state) async {
    final authProv = serviceLocator<AuthProvider>();
    final navProv = serviceLocator<NavigationProvider>();
    // precacheImage(AssetImage('assets/bg/bg.webp'), context);

    final localFutures = await Future.wait<dynamic>([
      authProv.isUserLoggedIn(),
      navProv.loadIsFirstLaunch(),
    ]);

    final isFirstLaunch = localFutures.last as bool;
    final isUserLoggedIn = localFutures.first as bool;

    if (isFirstLaunch) {
      FlutterNativeSplash.remove();
      return null;
    }

    if (isUserLoggedIn) {
      // get user profile
      FlutterNativeSplash.remove();
      return NavigationScreen.id;
    }

    FlutterNativeSplash.remove();
    return WelcomeScreen.id;
  }

  static Future<String?> navigationRedirection(BuildContext context, GoRouterState state) async {
    final authProv = serviceLocator<AuthProvider>();

    // Check if the user is logged in and has a completed profile
    final isProfileSetup = authProv.appUser?.isProfileSetup ?? false;

    if (!isProfileSetup) {
      // If profile is not set up, redirect to the UsernameScreen
      FlutterNativeSplash.remove();
      return UsernameScreen.id;
    }

    // Remove the native splash screen once profile setup is complete
    FlutterNativeSplash.remove();

    // No redirection needed, return null
    return null;
  }
}
