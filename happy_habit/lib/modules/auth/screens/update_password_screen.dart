import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';

import '../../../core/services/validators.dart';
import '../../../core/shared/widgets/custom_button.dart';
import '../../../core/shared/widgets/custom_text_field.dart';
import '../../../core/shared/widgets/root_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const id = 'UpdatePasswordScreen';

  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _isLoading = ValueNotifier(false);

  final _newPassword = InputDescriptor();
  final _currentPassword = InputDescriptor();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _isLoading.dispose();
    _newPassword.dispose();
    _currentPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      isLoading: _isLoading,
      title: 'Forget Password',
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: CustomButton(
          label: 'Update Password',
          onPressed: _updatePassword,
        ),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _validateMode,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            20.height,
            CustomTextField.obscure(
              hint: 'New Password',
              showHintAsTitle: true,
              descriptor: _newPassword,
              validator: (value) => Validators.emptyValidationCheck(
                value,
                message: 'Enter username',
              ),
            ),
            10.height,
            CustomTextField.obscure(
              showHintAsTitle: true,
              hint: 'Current Password',
              descriptor: _currentPassword,
              validator: (value) => Validators.passwordValidation(
                value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    _isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    _isLoading.value = false;
  }
}
