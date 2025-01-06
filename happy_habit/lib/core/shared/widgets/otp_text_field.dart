import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:pinput/pinput.dart';

import '../../services/validators.dart';
import '../../theme/theme_colors.dart';
import 'app_toast.dart';

class CustomOtpTextField extends StatefulWidget {
  final int length;
  final double? radius;
  final FocusNode? focusNode;
  final Function(String) onComplete;
  final Color? errorColor, borderColor;
  final TextEditingController controller;

  const CustomOtpTextField({
    super.key,
    this.radius,
    this.focusNode,
    this.errorColor,
    this.borderColor,
    required this.length,
    required this.controller,
    required this.onComplete,
  });

  @override
  State<CustomOtpTextField> createState() => _CustomOtpTextFieldState();
}

class _CustomOtpTextFieldState extends State<CustomOtpTextField> {
  @override
  void dispose() {
    // widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      autofocus: false,
      length: widget.length,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      validator: Validators.pinValidationCheck,
      errorTextStyle: context.bodyMedium?.copyWith(
        color: widget.errorColor ?? ThemeColor.error,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      onCompleted: (otp) {
        if (otp.trim().length == widget.length) {
          widget.onComplete(otp);
        } else {
          AppToast.show('Invalid OTP', type: AppToastType.error);
        }
      },
      defaultPinTheme: PinTheme(
        width: 72.r,
        height: 60.r,
        textStyle: context.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
          border: Border.all(
            width: 1,
            color: widget.borderColor ?? ThemeColor.border,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4.0,
              offset: Offset(0, 4.0),
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
