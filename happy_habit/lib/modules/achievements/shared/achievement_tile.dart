import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../services/achievement.dart';

class AchievementTile extends StatelessWidget {
  final bool isAward;
  final Achievement achievement;

  const AchievementTile({
    super.key,
    this.isAward = false,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: isAward ? null : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Custom activity',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SvgPicture.asset(
            achievement.svg,
            width: 63.w,
            height: 83.h,
          ),
          Text(
            achievement.title,
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _status,
            style: context.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: ThemeColor.primaryV2,
            ),
          ),
        ],
      ),
    );
  }

  String get _status {
    const total = 10;
    if (achievement.score < total) {
      return '${achievement.score}/$total';
    } else {
      return 'Complete';
    }
  }
}
