import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/theme/theme_colors.dart';

class SyncNowButton extends StatelessWidget {
  const SyncNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000), // #00000033 with alpha value
            offset: Offset(0, 4), // 0px horizontal, 4px vertical offset
            blurRadius: 4.8, // Blur radius of 4.8px
            spreadRadius: 0, // No spread (0px)
          ),
        ],
      ),
      child: Text(
        'Sync Now',
        style: context.bodySmall?.copyWith(
          color: ThemeColor.skyBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
