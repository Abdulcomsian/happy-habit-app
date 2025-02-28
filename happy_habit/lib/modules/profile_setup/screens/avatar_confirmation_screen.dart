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
import 'package:happy_habit/modules/profile_setup/services/avatar_attributes.dart';
import 'package:rive/rive.dart';

import '../services/profile_setup_provider.dart';

class AvatarConfirmationScreen extends StatefulWidget {
  static const id = 'AvatarConfirmationScreen';

  final Artboard artboard;
  final AvatarAttributes attributes;

  const AvatarConfirmationScreen({
    super.key,
    required this.artboard,
    required this.attributes,
  });

  @override
  State<AvatarConfirmationScreen> createState() => _AvatarConfirmationScreenState();
}

class _AvatarConfirmationScreenState extends State<AvatarConfirmationScreen> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      isLoading: _isLoading,
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
    _isLoading.value = true;
    final success = await prov.saveCharacter(widget.artboard, widget.attributes);
    _isLoading.value = false;
    if (success && mounted) context.goNamed(NavigationScreen.id);
  }
}
