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
import 'package:happy_habit/modules/navigation/navigation_screen.dart';
import 'package:happy_habit/modules/profile_setup/services/character_attributes.dart';
import 'package:rive/rive.dart';

import '../services/profile_setup_provider.dart';

class CharacterConfirmationScreen extends StatefulWidget {
  static const id = 'CharacterConfirmationScreen';

  final Artboard artboard;
  final CharacterAttributes attributes;

  const CharacterConfirmationScreen({
    super.key,
    required this.artboard,
    required this.attributes,
  });

  @override
  State<CharacterConfirmationScreen> createState() => _CharacterConfirmationScreenState();
}

class _CharacterConfirmationScreenState extends State<CharacterConfirmationScreen> {
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
            child: SizedBox(
              width: 126.w,
              height: 384.h,
              child: Rive(
                artboard: widget.artboard,
              ),
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
    final prov = serviceLocator<ProfileSetupProvider>();
    final success = await prov.saveCharacter(widget.artboard, widget.attributes);
    if (success && mounted) context.goNamed(NavigationScreen.id);
  }
}
