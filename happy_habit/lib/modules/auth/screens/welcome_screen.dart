import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/auth/screens/sign_in_screen.dart';
import 'package:happy_habit/modules/auth/shared/social_auth_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = '/WelcomeScreen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            AppAssets.loginBg,
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Let’s Get Started!',
                    style: context.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  10.height,
                  Text(
                    'Begin your journey towards building better habits today!',
                    textAlign: TextAlign.center,
                    style: context.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  20.height,
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        child: CustomButton(
                          label: 'Login',
                          onPressed: () => context.pushNamed(LoginScreen.id),
                          color: Colors.white,
                        ),
                      ),
                      10.width,
                      Flexible(
                        child: CustomButton(
                          label: 'Sign up',
                          onPressed: () => context.pushNamed(SignInScreen.id),
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  SocialAuthButtons(),
                  60.height,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
