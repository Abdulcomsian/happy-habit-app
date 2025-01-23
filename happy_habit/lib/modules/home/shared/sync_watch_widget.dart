import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/home/shared/sync_now_button.dart';

class SyncWatchWidget extends StatelessWidget {
  const SyncWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 147.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 1.sw,
            height: 115.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: ThemeColor.skyBlue,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sync Your',
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Apple health/Google fit to transfer\nsleep data.',
                  style: context.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                SyncNowButton(),
              ],
            ),
          ),
          Positioned(
            right: 0,
            width: 116.w,
            height: 147.h,
            child: Image.asset(
              AppIcons.syncWatch,
            ),
          ),
        ],
      ),
    );
  }
}
