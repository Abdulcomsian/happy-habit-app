import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../theme/theme_colors.dart';
import 'tap_widget.dart';

class CustomUpgradeWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String svg, title, description, buttonText;

  const CustomUpgradeWidget({
    super.key,
    this.onTap,
    required this.svg,
    required this.title,
    required this.buttonText,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 27.r,
                backgroundColor: ThemeColor.primary.withValues(alpha: 0.2),
                child: SvgPicture.asset(
                  svg,
                  width: 25.r,
                  height: 25.r,
                ),
              ),
              20.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    description,
                    style: context.bodySmall?.copyWith(color: ThemeColor.hint),
                  ),
                ],
              ),
            ],
          ),
          10.height,
          TapWidget(
            onTap: onTap,
            radius: 10.r,
            color: ThemeColor.primary,
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: Text(
              buttonText,
              style: context.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
