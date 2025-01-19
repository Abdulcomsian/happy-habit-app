import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../progress/services/activity.dart';

class GoalTile extends StatelessWidget {
  final Activity activity;

  const GoalTile({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          SvgPicture.asset(
            'assets/icons/${activity.title}.svg',
            width: 50.r,
            height: 50.r,
          ),
          13.width,
          Expanded(
            child: Text(
              activity.title.capitalize(),
              style: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '8 HOURS',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
