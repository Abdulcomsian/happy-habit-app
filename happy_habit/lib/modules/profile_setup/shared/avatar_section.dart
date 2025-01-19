import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/screens/avatar_confirmation_screen.dart';

import '../../../core/shared/widgets/tap_widget.dart';

class AvatarSection extends StatelessWidget {
  final String avatar;

  const AvatarSection({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
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
          child: Image.asset(
            avatar,
            width: 174.w,
            height: 316.h,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
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
                  onTap: () => context.pushNamed(AvatarConfirmationScreen.id, extra: {
                    'avatar': avatar,
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
