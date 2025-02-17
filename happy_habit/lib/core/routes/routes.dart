import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/routes/route_helper.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/auth/screens/welcome_screen.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/onboarding/onboarding_screen.dart';
import 'package:happy_habit/modules/social/screens/social_screen.dart';

import '../../modules/achievements/screens/achievements_screen.dart';
import '../../modules/activity/screens/activity_result_screen.dart';
import '../../modules/activity/screens/activity_session_screen.dart';
import '../../modules/auth/screens/forgot_password_screen.dart';
import '../../modules/auth/screens/sign_up_screen.dart';
import '../../modules/auth/screens/update_password_screen.dart';
import '../../modules/chat/chat_screen.dart';
import '../../modules/profile/screens/about_us_screen.dart';
import '../../modules/profile/screens/edit_profile_screen.dart';
import '../../modules/profile/screens/help_center_screen.dart';
import '../../modules/profile/screens/notifications_screen.dart';
import '../../modules/profile/screens/profile_screen.dart';
import '../../modules/profile/screens/setting_screen.dart';
import '../../modules/profile/screens/streak_screen.dart';
import '../../modules/profile_setup/screens/character_confirmation_screen.dart';
import '../../modules/profile_setup/screens/character_selection_screen.dart';
import '../../modules/profile_setup/screens/edit_avatar_screen.dart';
import '../../modules/profile_setup/screens/goals_setup_screen.dart';
import '../../modules/profile_setup/screens/username_screen.dart';
import '../../modules/store/screens/cart_screen.dart';
import '../../modules/store/screens/purchase_confirmation_screen.dart';
import '../../modules/store/screens/store_screen.dart';
import '../../modules/subscription/subscription_screen.dart';
import '../../modules/transition_screen.dart';

class Routes {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routers = GoRouter(
    navigatorKey: rootNavigatorKey,
    // initialLocation: TransitionScreen.id,
    initialLocation: OnboardingScreen.id,
    // initialLocation: NavigationScreen.id,
    // initialLocation: SubscriptionScreen.id,
    routes: [
      GoRoute(
        path: TransitionScreen.id,
        name: TransitionScreen.id,
        redirect: RouteHelper.unauthorizedRedirection,
        builder: (context, state) => const TransitionScreen(),
      ),
      GoRoute(
        path: SubscriptionScreen.id,
        name: SubscriptionScreen.id,
        redirect: RouteHelper.unauthorizedRedirection,
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: OnboardingScreen.id,
        name: OnboardingScreen.id,
        redirect: RouteHelper.onAppStartup,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: WelcomeScreen.id,
        name: WelcomeScreen.id,
        builder: (context, state) => WelcomeScreen(),
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
            builder: (context, state) => UpdatePasswordScreen(
              uid: state.asMap['uid'],
            ),
          ),
        ],
      ),
      GoRoute(
        path: SignUpScreen.id,
        name: SignUpScreen.id,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: UsernameScreen.id,
        name: UsernameScreen.id,
        builder: (context, state) => const UsernameScreen(),
      ),
      GoRoute(
        path: GoalsSetupScreen.id,
        name: GoalsSetupScreen.id,
        builder: (context, state) => const GoalsSetupScreen(),
      ),
      GoRoute(
        path: CharacterSelectionScreen.id,
        name: CharacterSelectionScreen.id,
        builder: (context, state) => const CharacterSelectionScreen(),
        routes: [
          GoRoute(
            path: EditAvatarScreen.id,
            name: EditAvatarScreen.id,
            builder: (context, state) => const EditAvatarScreen(),
            routes: [
              GoRoute(
                path: CharacterConfirmationScreen.id,
                name: CharacterConfirmationScreen.id,
                builder: (context, state) => CharacterConfirmationScreen(
                  artboard: state.asMap['artboard'],
                  attributes: state.asMap['attributes'],
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: NavigationScreen.id,
        name: NavigationScreen.id,
        redirect: RouteHelper.navigationRedirection,
        builder: (context, state) => NavigationScreen(),
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
            builder: (context, state) => StoreScreen(
              shouldScrollToWallpaper: state.asMap['shouldScrollToWallpaper'] ?? false,
            ),
            routes: [
              GoRoute(
                path: CartScreen.id,
                name: CartScreen.id,
                builder: (context, state) => CartScreen(
                  item: state.asMap['item'],
                  // items: state.asMap['items'],
                  // packs: state.asMap['packs'],
                ),
                routes: [
                  GoRoute(
                    path: PurchaseConfirmationScreen.id,
                    name: PurchaseConfirmationScreen.id,
                    builder: (context, state) => const PurchaseConfirmationScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: ActivitySessionScreen.id,
            name: ActivitySessionScreen.id,
            builder: (context, state) => ActivitySessionScreen(
              activity: state.asMap['activity'],
              duration: state.asMap['duration'],
            ),
            routes: [
              GoRoute(
                path: ActivityResultScreen.id,
                name: ActivityResultScreen.id,
                builder: (context, state) => ActivityResultScreen(
                  duration: state.asMap['duration'],
                ),
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
