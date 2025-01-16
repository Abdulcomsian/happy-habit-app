import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/routes/route_helper.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
import 'package:happy_habit/modules/home/home_screen.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/onboarding/onboarding_screen.dart';
import 'package:happy_habit/modules/social/screens/social_screen.dart';

import '../../modules/achievements/screens/achievements_screen.dart';
import '../../modules/activity/screens/activity_result_screen.dart';
import '../../modules/activity/screens/activity_session_screen.dart';
import '../../modules/auth/screens/forgot_password_screen.dart';
import '../../modules/auth/screens/sign_in_screen.dart';
import '../../modules/auth/screens/update_password_screen.dart';
import '../../modules/chat/chat_screen.dart';
import '../../modules/profile/screens/about_us_screen.dart';
import '../../modules/profile/screens/edit_profile_screen.dart';
import '../../modules/profile/screens/help_center_screen.dart';
import '../../modules/profile/screens/notifications_screen.dart';
import '../../modules/profile/screens/profile_screen.dart';
import '../../modules/profile/screens/setting_screen.dart';
import '../../modules/profile/screens/streak_screen.dart';
import '../../modules/progress/screens/progress_tracking_screen.dart';
import '../../modules/store/screens/store_screen.dart';

class Routes {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routers = GoRouter(
    navigatorKey: rootNavigatorKey,
    // initialLocation: OnboardingScreen.id,
    initialLocation: NavigationScreen.id,
    routes: [
      GoRoute(
        path: OnboardingScreen.id,
        name: OnboardingScreen.id,
        redirect: RouteHelper.onAppStartup,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: WelcomeScreen.id,
        name: WelcomeScreen.id,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: LoginScreen.id,
        name: LoginScreen.id,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: ForgotPasswordScreen.id,
            name: ForgotPasswordScreen.id,
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: UpdatePasswordScreen.id,
            name: UpdatePasswordScreen.id,
            builder: (context, state) => const UpdatePasswordScreen(),
          ),
        ],
      ),
      GoRoute(
        path: SignInScreen.id,
        name: SignInScreen.id,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: NavigationScreen.id,
        name: NavigationScreen.id,
        builder: (context, state) => NavigationScreen(),
        redirect: (context, state) {
          FlutterNativeSplash.remove();
          return null;
        },
        routes: [
          // GoRoute(
          //   path: ProgressTrackingScreen.id,
          //   name: ProgressTrackingScreen.id,
          //   builder: (context, state) => const ProgressTrackingScreen(),
          // ),
          GoRoute(
            path: AchievementsScreen.id,
            name: AchievementsScreen.id,
            builder: (context, state) => const AchievementsScreen(),
          ),
          GoRoute(
            path: StoreScreen.id,
            name: StoreScreen.id,
            builder: (context, state) => const StoreScreen(),
          ),
          GoRoute(
            path: ActivitySessionScreen.id,
            name: ActivitySessionScreen.id,
            builder: (context, state) => ActivitySessionScreen(
              duration: state.asMap['duration'],
            ),
            routes: [
              GoRoute(
                path: ActivityResultScreen.id,
                name: ActivityResultScreen.id,
                builder: (context, state) => const ActivityResultScreen(),
              ),
            ],
          ),
          GoRoute(
            path: ProfileScreen.id,
            name: ProfileScreen.id,
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: SettingScreen.id,
                name: SettingScreen.id,
                builder: (context, state) => const SettingScreen(),
                routes: [
                  GoRoute(
                    path: EditProfileScreen.id,
                    name: EditProfileScreen.id,
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                  GoRoute(
                    path: NotificationsScreen.id,
                    name: NotificationsScreen.id,
                    builder: (context, state) => const NotificationsScreen(),
                  ),
                  GoRoute(
                    path: AboutUsScreen.id,
                    name: AboutUsScreen.id,
                    builder: (context, state) => const AboutUsScreen(),
                  ),
                  GoRoute(
                    path: HelpCenterScreen.id,
                    name: HelpCenterScreen.id,
                    builder: (context, state) => const HelpCenterScreen(),
                  ),
                  GoRoute(
                    path: StreakScreen.id,
                    name: StreakScreen.id,
                    builder: (context, state) => const StreakScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: SocialScreen.id,
            name: SocialScreen.id,
            builder: (context, state) => SocialScreen(
              desireIndex: state.asMap['desireIndex'],
            ),
            routes: [
              GoRoute(
                path: ChatScreen.id,
                name: ChatScreen.id,
                builder: (context, state) => const ChatScreen(),
              ),
            ],
          ),
        ],
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
