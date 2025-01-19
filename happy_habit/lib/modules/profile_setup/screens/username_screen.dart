import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/services/validators.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/custom_text_field.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/value_listenable_builder_2.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../services/profile_setup_provider.dart';
import 'goals_setup_screen.dart';

class UsernameScreen extends StatefulWidget {
  static const id = '/UsernameScreen';

  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  Timer? _debounceTimer;
  final prov = serviceLocator<ProfileSetupProvider>();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isUsernameValid = ValueNotifier(false);
  final ValueNotifier<bool> _isValidatingUsername = ValueNotifier(false);

  final _username = InputDescriptor();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _username.dispose();
    _isLoading.dispose();
    _debounceTimer?.cancel();
    _isUsernameValid.dispose();
    _isValidatingUsername.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      isLoading: _isLoading,
      title: 'Set a usernames',
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: ValueListenableBuilder(
          valueListenable: _isUsernameValid,
          builder: (context, isUsernameSetup, _) {
            return CustomButton(
              label: 'Set Username',
              onPressed: isUsernameSetup ? _setUsername : null,
            );
          },
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          20.height,
          Text(
            'Set Username',
            style: context.headlineSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          // 10.height,
          Text(
            'Please set your username',
            style: context.bodyMedium?.copyWith(
              color: ThemeColor.hint,
            ),
          ),
          40.height,
          Form(
            key: _formKey,
            autovalidateMode: _validateMode,
            child: CustomTextField(
              hint: 'Username',
              descriptor: _username,
              onChanged: _debounceValidateUsername,
              validator: (value) => Validators.emptyValidationCheck(
                value,
                message: 'Enter username',
              ),
            ),
          ),
          10.height,
          ValueListenableBuilder2(
            valueListenable1: _isValidatingUsername,
            valueListenable2: _isUsernameValid,
            builder: (context, validating, valid, _) {
              return Row(
                children: [
                  Text(validating ? 'Validating username...' : 'Username is '),
                  if (!validating)
                    Text(
                      valid ? 'valid' : 'invalid',
                      style: context.bodyMedium?.copyWith(
                        color: valid ? ThemeColor.success : ThemeColor.error,
                      ),
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  // Debounce method to ensure validation happens after 1 second of no input
  void _debounceValidateUsername(String username) {
    username = username.trim();

    if (username.isEmpty) {
      _isUsernameValid.value = false;
      _isValidatingUsername.value = false; // Stop validating immediately if the field is empty
      return;
    }

    // Cancel the previous timer if it exists
    _debounceTimer?.cancel();

    // Start a new timer with 1-second delay before calling the validation
    _debounceTimer = Timer(Duration(seconds: 1), () {
      if (_username.controller.text.trim().isNotEmpty) _validateUsername(username);
    });
  }

  Future<void> _validateUsername(String username) async {
    _isValidatingUsername.value = true;

    final success = await prov.validateUsername(username);
    _isUsernameValid.value = success;
    _isValidatingUsername.value = false;
  }

  Future<void> _setUsername() async {
    if (!_formKey.currentState!.validate()) {
      _validateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    _isLoading.value = true;

    final success = await prov.setUsername(_username.text);
    _isLoading.value = false;

    if (success) {
      // Navigate to the next screen (e.g., ProfileSetupCompleteScreen or wherever needed)
      if (mounted) context.pushReplacementNamed(GoalsSetupScreen.id);
    } else {
      // Show an error message
    }
  }
}
