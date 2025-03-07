import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/datetime_extension.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/activity/services/activity_provider.dart';
import 'package:happy_habit/modules/activity/shared/models/activity.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/widgets/circular_bounce_loader.dart';

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
          Consumer<ActivityProvider>(builder: (context, prov, _) {
            if (prov.isLoading) {
              return CircleBounceLoader();
            }

            if (prov.activities.isEmpty) {
              return Center(
                child: Text(
                  'no activity to show',
                  style: context.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              itemCount: prov.activities.length,
              padding: EdgeInsets.only(bottom: 30.h),
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => 10.height,
              itemBuilder: (context, i) => ActivityContentTile(
                activity: prov.activities[i],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ActivityContentTile extends StatelessWidget {
  final Activity activity;

  const ActivityContentTile({super.key, required this.activity});

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
                  activity.description,
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  activity.timestamp.toFormattedTimeStringForToday(),
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
