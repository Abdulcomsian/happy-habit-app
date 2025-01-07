import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/shared/social_auth_buttons.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';

import '../../../core/services/validators.dart';
import '../../../core/shared/widgets/custom_text_field.dart';
import '../../../core/shared/widgets/root_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _isLoading = ValueNotifier(false);

  final _email = InputDescriptor();
  final _password = InputDescriptor();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Login',
      isLoading: _isLoading,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            SocialAuthButtons(),
            10.height,
            CustomButton(
              label: 'Login',
              onPressed: _login,
            )
          ],
        ),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _validateMode,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            20.height,
            CustomTextField(
              descriptor: _email,
              showHintAsTitle: true,
              hint: 'Email or Username',
              validator: (value) => Validators.emptyValidationCheck(
                value,
                message: 'Enter username',
              ),
            ),
            10.height,
            CustomTextField.obscure(
              hint: 'Password',
              showHintAsTitle: true,
              descriptor: _password,
              validator: (value) => Validators.passwordValidation(value, applyLimit: false),
            ),
            7.height,
            Align(
              alignment: Alignment.centerRight,
              child: TapWidget(
                onTap: () => context.pushNamed(ForgotPasswordScreen.id),
                padding: EdgeInsets.all(3.r),
                child: Text(
                  'Forget Password?',
                  style: context.bodyMedium?.copyWith(
                    color: ThemeColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    _isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    serviceLocator<NavigationProvider>().storeIsFirstLaunch();
    _isLoading.value = false;
  }
}
