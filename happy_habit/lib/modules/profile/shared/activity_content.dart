import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

class ActivityContent extends StatelessWidget {
  const ActivityContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity of this week',
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          15.height,
          ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 30.h),
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => 10.height,
            itemBuilder: (context, i) => ActivityContentTile(),
          ),
        ],
      ),
    );
  }
}

class ActivityContentTile extends StatelessWidget {
  const ActivityContentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '9 XP earned by sleep goals',
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Today, 09:00 AM',
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            AppIcons.upward,
          )
        ],
      ),
    );
  }
}
