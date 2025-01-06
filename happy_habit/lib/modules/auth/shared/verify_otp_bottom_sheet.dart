import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/modals/bottom_sheet_layout.dart';
import 'package:happy_habit/core/shared/modals/custom_dialog.dart';
import 'package:happy_habit/core/shared/widgets/app_toast.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/otp_text_field.dart';
import '../../../core/theme/theme_colors.dart';

class VerifyOtpBottomSheet extends StatefulWidget {
  const VerifyOtpBottomSheet({super.key});

  @override
  State<VerifyOtpBottomSheet> createState() => _VerifyOtpBottomSheetState();
}

class _VerifyOtpBottomSheetState extends State<VerifyOtpBottomSheet> {
  final _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BottomSheetLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          60.height,
          Text(
            'OTP Verification',
            style: context.headlineSmall?.copyWith(
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  offset: Offset(0, 2.0),
                  color: Colors.black.withValues(alpha: 0.2),
                ),
              ],
            ),
          ),
          15.height,
          Text(
            'We have sent a OTP verification code on your phone number',
            textAlign: TextAlign.center,
            style: context.bodyMedium?.copyWith(
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  offset: Offset(0, 2.0),
                  color: Colors.black.withValues(alpha: 0.2),
                ),
              ],
            ),
          ),
          55.height,
          Form(
            key: _formKey,
            autovalidateMode: _validateMode,
            child: CustomOtpTextField(
              length: 4,
              onComplete: (pin) {},
              controller: _otpController,
              errorColor: ThemeColor.error,
            ),
          ),
          35.height,
          Text(
            'Didn\'t receive email?',
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You can resend code in ',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '55',
                style: context.bodyMedium?.copyWith(
                  color: ThemeColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' s',
                style: context.bodyMedium?.copyWith(
                  color: ThemeColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          46.height,
          CustomButton(
            label: 'Confirm',
            onPressed: _verifyOtp,
          ),
          40.height,
        ],
      ),
    );
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      // AppToast.show('Please enter OTP');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CustomDialog(
        onAction: _onSuccess ,
        svg: AppIcons.success,
        title: 'Verification Complete!',
        message: 'Thanks for your patience. Enjoy the all features of app',
      ),
    );
  }

  void _onSuccess () {
    Navigator.pop(context);
    Navigator.pop(context, true);
  }
}
