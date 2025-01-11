import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/update_password_screen.dart';

import '../../../core/services/validators.dart';
import '../../../core/shared/widgets/custom_text_field.dart';
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
          onPressed: _sendLink,
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

  Future<void> _sendLink() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    final response = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VerifyOtpBottomSheet(
        email: _email.text,
      ),
    ) as bool?;

    if (response ?? false) {
      if (mounted) context.pushNamed(UpdatePasswordScreen.id);
    }

    // _isLoading.value = true;
    // await Future.delayed(const Duration(milliseconds: 1000));
    // _isLoading.value = false;

    // if (mounted) {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (_) => CustomDialog(
    //       onAction: _onDone,
    //       actionLabel: 'Done',
    //       svg: AppIcons.mailSent,
    //       title: 'Check Your Email',
    //       message: 'Password reset link send to your email.',
    //     ),
    //   );
    // final response = await showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (_) => VerifyOtpBottomSheet(
    //     email: _email.text,
    //   ),
    // ) as bool?;
    //
    // if (response ?? false) {
    //   if (mounted) Navigator.pop(context);
    // }
    // }
  }
}
