import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/modals/custom_dialog.dart';
import 'package:happy_habit/core/shared/widgets/app_toast.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/fullscreen_.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';

import '../../../core/shared/modals/bottom_sheet_layout.dart';
import '../../../core/shared/widgets/otp_text_field.dart';
import '../../../core/theme/theme_colors.dart';

class VerifyOtpBottomSheet extends StatefulWidget {
  final String email;

  const VerifyOtpBottomSheet({super.key, required this.email});

  @override
  State<VerifyOtpBottomSheet> createState() => _VerifyOtpBottomSheetState();
}

class _VerifyOtpBottomSheetState extends State<VerifyOtpBottomSheet> with WidgetsBindingObserver {
  final _otpController = TextEditingController();
  final _authProv = serviceLocator<AuthProvider>();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _sendOTP(),
    );
  }

  /// makes the API call to generate OTP on the provided email
  Future<void> _sendOTP() async {
    AppLoader.showFullScreenLoader();
    final isOtpSent = await _authProv.generateOTP(widget.email);
    AppLoader.hideLoader();

    if (isOtpSent) {
      // todo: reset timer
      _startTimer();
    }
  }

  late Timer _timer;
  final ValueNotifier<Duration> _remainingTime = ValueNotifier(Duration.zero);

  void _startTimer() {
    _remainingTime.value = const Duration(seconds: 30);
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (_remainingTime.value.inSeconds > 0) {
      _remainingTime.value = _remainingTime.value - const Duration(seconds: 1);
    } else {
      _timer.cancel();
    }
  }

  void _handleAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in background, save remaining time if needed
      _updateTimer(_timer);
    } else if (state == AppLifecycleState.resumed) {
      // App is back in foreground, you may want to update the UI if needed
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _handleAppLifecycleState(state);
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    return BottomSheetLayout(
      child: ValueListenableBuilder(
        valueListenable: _remainingTime,
        builder: (context, remainingTime, _) {
          return Column(
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
                'We have sent a OTP verification code on your email',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive email?',
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (remainingTime.inSeconds == 0)
                    TapWidget(
                      onTap: _sendOTP,
                      padding: EdgeInsets.all(3.r),
                      child: Text(
                        'Resend',
                        style: context.bodyMedium?.copyWith(
                          color: ThemeColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              if (remainingTime.inSeconds != 0)
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
                      '${remainingTime.inSeconds}',
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
          );
        },
      ),
    );
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      AppToast.show('Please enter OTP');
      return;
    }
    AppLoader.showFullScreenLoader();
    // todo: verify OTP by API
    await Future.delayed(const Duration(seconds: 2));
    AppLoader.hideLoader();
    if (mounted) Navigator.pop(context, true);
  }
}
