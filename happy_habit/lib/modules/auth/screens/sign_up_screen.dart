import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/services/validators.dart';
import 'package:happy_habit/core/shared/widgets/app_toast.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/custom_switcher.dart';
import 'package:happy_habit/core/shared/widgets/custom_text_field.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/auth/shared/verify_otp_bottom_sheet.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/shared/modals/custom_dialog.dart';

class SignUpScreen extends StatefulWidget {
  static const id = '/SignUpScreen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _prov = serviceLocator<AuthProvider>();

  final _isLoading = ValueNotifier(false);
  final _allowedTermsAndConditions = ValueNotifier(false);

  final _name = InputDescriptor();
  final _email = InputDescriptor();
  final _password = InputDescriptor();
  final _confirmPassword = InputDescriptor();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _isLoading.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
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
      child: Form(
        key: _formKey,
        autovalidateMode: _validateMode,
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
              hint: 'Name',
              descriptor: _name,
              validator: (value) => Validators.emptyValidationCheck(
                value,
                message: 'Enter name',
              ),
            ),
            15.height,
            CustomTextField(
              hint: 'Email',
              descriptor: _email,
              validator: Validators.emailValidation,
              keyboardType: TextInputType.emailAddress,
            ),
            15.height,
            CustomTextField.obscure(
              hint: 'Password',
              descriptor: _password,
              validator: Validators.passwordValidation,
            ),
            15.height,
            CustomTextField.obscure(
              hint: 'Repeat Password',
              descriptor: _confirmPassword,
              validator: (vl) => Validators.passwordValidation(
                vl,
                value2: _password.controller.text,
              ),
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
                    },
                  ),
                  10.width,
                  context.richText('You accept the *Terms & Conditions*'),
                ],
              ),
            ),
            40.height,
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    if (!_allowedTermsAndConditions.value) {
      AppToast.show('Please accept to our Terms & Conditions');
      // Fluttertoast.showToast(msg: 'Please accept to our Terms & Conditions');
      return;
    }

    final body = {
      'name': _name.text,
      'email': _email.text,
      'password': _password.text,
      'tc_status': _allowedTermsAndConditions.value,
    };

    _isLoading.value = true;
    final int? uid = await _prov.signup(body);
    _isLoading.value = false;

    if (uid != null && mounted) {
      final isVerified = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => VerifyOtpBottomSheet(uid: uid),
      ) as bool?;

      if (isVerified ?? false) {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => CustomDialog(
              onAction: _onSuccess,
              svg: AppIcons.success,
              title: 'Verification Complete!',
              message: 'Thanks for your patience. Enjoy the all features of app',
            ),
          );
        }
      }
    }
  }

  void _onSuccess() {
    context.pushReplacementNamed(LoginScreen.id);
  }
}
