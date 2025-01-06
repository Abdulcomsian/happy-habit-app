import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';

import '../../../core/shared/widgets/custom_text_field.dart';
import '../../../core/shared/widgets/root_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RootScreen(
      isLoading: _isLoading,
      title: 'Login',
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          20.height,
          CustomTextField(
            hint: 'Email or Username',
            descriptor: InputDescriptor(),
          ),
          10.height,
          CustomTextField(
            hint: 'Password',
            descriptor: InputDescriptor(),
          ),
        ],
      ),
    );
  }
}
