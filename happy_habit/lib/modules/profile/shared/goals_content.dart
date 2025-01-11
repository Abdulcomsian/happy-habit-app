import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

class GoalsContent extends StatelessWidget {
  const GoalsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goals',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              context.richText(
                'See Progress  *Edit Goals*',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          15.height,
          ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 30.h),
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => 10.height,
            itemBuilder: (context, i) => GoalContentTile(
              activity: ['sleep', 'screen', 'workout', 'focus'][i],
            ),
          ),
        ],
      ),
    );
  }
}

class GoalContentTile extends StatelessWidget {
  final String activity;

  const GoalContentTile({super.key, required this.activity});

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
          SvgPicture.asset(
            'assets/icons/$activity.svg',
            width: 50.r,
            height: 50.r,
          ),
          13.width,
          Expanded(
            child: Text(
              '${activity.capitalize()} Time',
              style: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '01h:45m',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
