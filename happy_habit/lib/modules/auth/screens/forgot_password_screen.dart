import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/update_password_screen.dart';

import '../../../core/services/providers.dart';
import '../../../core/services/validators.dart';
import '../../../core/shared/widgets/custom_text_field.dart';
import '../services/auth_provider.dart';
import '../shared/verify_otp_bottom_sheet.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const id = 'ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = InputDescriptor();
  final _isLoading = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _email.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      isLoading: _isLoading,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: CustomButton(
          label: 'Send Link',
          onPressed: _sendOtp,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          context.richText(
            'Forget *Password?*',
            withTag: true,
            style: context.headlineSmall?.copyWith(),
          ),
          15.height,
          Text('Please enter your email address to receive password. '),
          28.height,
          Form(
            key: _formKey,
            autovalidateMode: _validateMode,
            child: CustomTextField(
              descriptor: _email,
              hint: 'Email Address',
              validator: Validators.emailValidation,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    _isLoading.value = true;
    final int? uid = await serviceLocator<AuthProvider>().forgotPassword(_email.text);
    _isLoading.value = false;

    if (uid != null && mounted) {
      final isVerified = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => VerifyOtpBottomSheet(
          uid: uid,
        ),
      ) as bool?;

      if (isVerified ?? false) {
        if (mounted) {
          context.pushNamed(UpdatePasswordScreen.id, extra: {
            'uid': uid,
          });
        }
      }
    }
  }
}
