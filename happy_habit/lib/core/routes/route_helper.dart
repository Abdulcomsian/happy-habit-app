import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/profile_setup/screens/username_screen.dart';

import '../../modules/profile_setup/screens/character_selection_screen.dart';
import '../../modules/profile_setup/screens/goals_setup_screen.dart';
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
      // final isSuccess = await authProv.getUserProfile();
      FlutterNativeSplash.remove();
      // return isSuccess ? NavigationScreen.id : LoginScreen.id;
      return NavigationScreen.id;
    }

    FlutterNativeSplash.remove();
    return WelcomeScreen.id;
  }

  static Future<String?> navigationRedirection(BuildContext context, GoRouterState state) async {
    final authProv = serviceLocator<AuthProvider>();

    if (authProv.appUser?.username == null) {
      // If Username is not set up, redirect to the UsernameScreen
      FlutterNativeSplash.remove();
      return UsernameScreen.id; // todo: for release
      // return null; // todo: for development
    }

    if (authProv.appUser?.areGoalsReady == false) {
      // If Goals are not set up, redirect to the GoalsSetupScreen
      FlutterNativeSplash.remove();
      return GoalsSetupScreen.id;
      // return null;
    }

    if (authProv.appUser?.gender == null) {
      // If character is not set up, redirect to the AvatarSelectionScreen
      FlutterNativeSplash.remove();
      return CharacterSelectionScreen.id;
      // return null;
    }


    // Remove the native splash screen once profile setup is complete
    FlutterNativeSplash.remove();

    // No redirection needed, return null
    return null;
  }

  static Future<String?> unauthorizedRedirection(BuildContext context, GoRouterState state) async {
    // Remove the native splash screen once profile setup is complete
    FlutterNativeSplash.remove();

    // No redirection needed, return null
    return null;
  }
}
