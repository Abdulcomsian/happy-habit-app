import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/shared/helper_functions/media/media_provider.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/profile_setup/screens/username_screen.dart';

import '../../modules/profile_setup/screens/character_selection_screen.dart';
import '../../modules/profile_setup/screens/goals_setup_screen.dart';
import '../avatar/avatar_provider.dart';
import '../services/providers.dart';

class RouteHelper {
  static Future<String?> onAppStartup(BuildContext context, GoRouterState state) async {
    final authProv = serviceLocator<AuthProvider>();
    final navProv = serviceLocator<NavigationProvider>();
    final avatarProv = serviceLocator<AvatarProvider>();
    final mediaProv = serviceLocator<MediaProvider>();
    // precacheImage(AssetImage('assets/bg/bg.webp'), context);

    final localFutures = await Future.wait<dynamic>([
      authProv.isUserLoggedIn(),
      avatarProv.loadCharacters(),
      navProv.loadIsFirstLaunch(),
    ]);

    final isFirstLaunch = localFutures.last as bool;
    final isUserLoggedIn = localFutures.first as bool;

    if (isFirstLaunch) {
      FlutterNativeSplash.remove();
      return null;
    }

    final List<Future> futures = [
      mediaProv.getMusics(),
    ];

    if (isUserLoggedIn) {
      futures.add(authProv.getUserProfile());
    }

    final apiFutures = await Future.wait<dynamic>(futures);

    if (isUserLoggedIn) {
      FlutterNativeSplash.remove();
      return apiFutures.last ? NavigationScreen.id : WelcomeScreen.id;
      // return NavigationScreen.id;
    }

    FlutterNativeSplash.remove();
    return WelcomeScreen.id;
  }

  static Future<String?> navigationRedirection(BuildContext context, GoRouterState state) async {
    final authProv = serviceLocator<AuthProvider>();

    if (authProv.appUser?.username == null) {
      // If Username is not set up, redirect to the UsernameScreen
      FlutterNativeSplash.remove();
      return UsernameScreen.id;
    }

    if (authProv.appUser?.areGoalsReady == false) {
      // If Goals are not set up, redirect to the GoalsSetupScreen
      FlutterNativeSplash.remove();
      return GoalsSetupScreen.id;
    }

    if (authProv.appUser?.characterAttributes == null) {
      // If character is not set up, redirect to the AvatarSelectionScreen
      FlutterNativeSplash.remove();
      return CharacterSelectionScreen.id;
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
