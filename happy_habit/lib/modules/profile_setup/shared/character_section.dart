import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/screens/character_confirmation_screen.dart';
import 'package:happy_habit/modules/profile_setup/services/character_attributes.dart';
import 'package:rive/rive.dart';

import '../../../core/shared/widgets/tap_widget.dart';

class CharacterSection extends StatelessWidget {
  final Artboard artboard;
  final CharacterAttributes attributes;

  const CharacterSection({
    super.key,
    required this.artboard,
    required this.attributes,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Container(
            width: 1.sw,
            height: 374.h,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
            ),
            child: Stack(
              children: [
                Rive(
                  artboard: artboard,
                ),
                Positioned(
                  bottom: 0,
                  width: 1.sw,
                  child: Opacity(
                    opacity: 0.6,
                    child: m.Image.asset(
                      AppIcons.shadow,
                      width: 140.r,
                      height: 100.r,
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
          width: 1.sw,
          top: kToolbarHeight.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TapWidget(
                  radius: 7,
                  padding: EdgeInsets.all(7.r),
                  borderColor: ThemeColor.primary,
                  onTap: Navigator.of(context).maybePop,
                  color: ThemeColor.background.withValues(alpha: 0.3),
                  child: Icon(Icons.close, color: ThemeColor.primary),
                ),
                TapWidget(
                  radius: 6.r,
                  color: ThemeColor.primary,
                  padding: EdgeInsets.symmetric(horizontal: 12.5.w, vertical: 6.h),
                  onTap: () => context.pushNamed(CharacterConfirmationScreen.id, extra: {
                    'artboard': artboard,
                    'attributes': attributes,
                  }),
                  child: Text(
                    'Save',
                    style: context.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
