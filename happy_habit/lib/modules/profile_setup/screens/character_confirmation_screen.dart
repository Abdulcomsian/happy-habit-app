import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/custom_outlined_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/services/auth_provider.dart';
import 'package:happy_habit/modules/navigation/navigation_screen.dart';

class CharacterConfirmationScreen extends StatefulWidget {
  static const id = 'CharacterConfirmationScreen';

  final String gender;

  const CharacterConfirmationScreen({super.key, required this.gender});

  @override
  State<CharacterConfirmationScreen> createState() => _CharacterConfirmationScreenState();
}

class _CharacterConfirmationScreenState extends State<CharacterConfirmationScreen> {
  final _authProv = serviceLocator<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Created Successfully',
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            CustomOutlinedButton(
              label: 'Change',
              onPressed: () => Navigator.pop(context),
            ),
            15.height,
            CustomButton(
              label: 'Save',
              onPressed: _setProfile,
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
            ),
            child: Image.asset(
              widget.gender,
              width: 126.w,
              height: 384.h,
              alignment: Alignment.bottomCenter,
            ),
          ),
          10.height,
          Text(
            'Created Successfully',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Your avatar has been created successfully',
            style: context.bodyMedium?.copyWith(
              color: ThemeColor.hint,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setProfile() async {
    final success = await _authProv.saveCharacter(widget.gender);
    if (success && mounted) context.goNamed(NavigationScreen.id);
  }
}
