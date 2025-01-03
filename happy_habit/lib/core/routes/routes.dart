import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/routes/route_helper.dart';
import 'package:happy_habit/modules/home/home_screen.dart';

class Routes {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routers = GoRouter(
    initialLocation: HomeScreen.id,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: HomeScreen.id,
        name: HomeScreen.id,
        redirect: RouteHelper.onAppStartup,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

extension _GoRouterStateExtraExtension on GoRouterState {
  /// Extracts `extra` as a [Map<String, dynamic>] from GoRouterState
  Map<String, dynamic> get asMap {
    if (extra != null && extra is Map<String, dynamic>) {
      return extra as Map<String, dynamic>;
    }
    return {}; // Return an empty map if `extra` is not a Map<String, dynamic>
  }
}
