import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/custom_switcher.dart';
import 'package:happy_habit/core/shared/widgets/custom_text_field.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/auth/shared/verify_otp_bottom_sheet.dart';

class SignInScreen extends StatefulWidget {
  static const id = '/SignInScreen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _isLoading = ValueNotifier(false);
  final _allowedTermsAndConditions = ValueNotifier(false);

  @override
  void dispose() {
    _isLoading.dispose();
    _allowedTermsAndConditions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      isLoading: _isLoading,
      title: 'Create an account',
      crossAxisAlignment: CrossAxisAlignment.start,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: CustomButton(
          label: 'Create Account',
          onPressed: _signUp,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          15.height,
          context.richText(
            'Create and *enjoy!*',
            withTag: true,
            style: context.headlineSmall?.copyWith(),
          ),
          15.height,
          Text(
            'Logging in to your account. Access personalized features, save your preferences, and experience a seamless journey through our application',
          ),
          40.height,
          CustomTextField(
            hint: 'Username',
            descriptor: InputDescriptor(),
          ),
          15.height,
          CustomTextField(
            hint: 'Username',
            descriptor: InputDescriptor(),
          ),
          15.height,
          CustomTextField.obscure(
            hint: 'Password',
            descriptor: InputDescriptor(),
          ),
          15.height,
          CustomTextField.obscure(
            hint: 'Repeat Password',
            descriptor: InputDescriptor(),
          ),
          15.height,
          TapWidget(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            onTap: () => _allowedTermsAndConditions.value = !_allowedTermsAndConditions.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                    valueListenable: _allowedTermsAndConditions,
                    builder: (context, vl, _) {
                      return CustomSwitcher(
                        key: ValueKey(vl),
                        child: Icon(
                          size: 20.r,
                          vl ? Icons.check_circle : Icons.circle_outlined,
                          color: vl ? ThemeColor.primary : ThemeColor.fontBlack,
                        ),
                      );
                    }),
                10.width,
                context.richText('You accept the *Terms & Conditions*'),
              ],
            ),
          ),
          40.height,
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    final response = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VerifyOtpBottomSheet(),
    ) as bool?;

    if (response ?? false) {
      _isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) context.pushReplacementNamed(LoginScreen.id);
      _isLoading.value = false;
    }
  }
}
