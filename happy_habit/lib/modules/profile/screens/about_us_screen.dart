import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/theme/theme_colors.dart';

class AboutUsScreen extends StatelessWidget {
  static const id = 'AboutUsScreen';

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'About Us',
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
                'About Us',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          15.height,
          Text(
            'Introduction',
            style: context.titleSmall,
          ),
          15.height,
        ],
      ),
    );
  }
}
