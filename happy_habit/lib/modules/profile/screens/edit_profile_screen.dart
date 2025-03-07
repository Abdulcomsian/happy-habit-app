import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/update_password_screen.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/profile/shared/profile_header.dart';

import '../../../core/services/validators.dart';
import '../../../core/shared/widgets/custom_button.dart';
import '../../../core/shared/widgets/custom_text_field.dart';
import '../../profile_setup/screens/edit_avatar_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = 'EditProfileScreen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _authProv = serviceLocator<AuthProvider>();
  late final InputDescriptor _username;
  late final InputDescriptor _email;
  late final InputDescriptor _password;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _username = InputDescriptor(initialValue: _authProv.appUser?.username);
    _email = InputDescriptor(initialValue: _authProv.appUser?.email);
    _password = InputDescriptor(initialValue: '********');
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Edit Profile',
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: CustomButton(
          label: 'Save',
          onPressed: _save,
        ),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: _validateMode,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            10.height,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: ThemeColor.primaryGradient,
                  ),
                ),
                12.width,
                Text(
                  'Personal Information',
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            20.height,
            Row(
              children: [
                ProfileAvatar(),
                22.width,
                Flexible(
                  child: CustomButton(
                    label: 'Edit Avatar',
                    color: ThemeColor.primary,
                    icon: Icon(Icons.mode_edit, color: Colors.white),
                    onPressed: () => context.pushNamed(EditAvatarScreen.id),
                  ),
                ),
              ],
            ),
            20.height,
            CustomTextField(
              hint: 'Username',
              descriptor: _username,
              validator: (value) => Validators.emptyValidationCheck(
                value,
                message: 'Enter username',
              ),
            ),
            15.height,
            CustomTextField(
              hint: 'Email',
              descriptor: _email,
              validator: Validators.emailValidation,
            ),
            15.height,
            CustomTextField.obscure(
              hint: 'Password',
              showIcons: true,
              descriptor: _password,
              onTap: () => context.pushNamed(UpdatePasswordScreen.id, extra: {
                'shouldPop': true,
                'uid': _authProv.appUser?.id,
              }),
            ),
            15.height,
            CustomTextField(
              descriptor: InputDescriptor(),
              hint: 'UTC+01:00 Berlin, Stockh...',
              validator: Validators.emptyValidationCheck,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
  }
}
