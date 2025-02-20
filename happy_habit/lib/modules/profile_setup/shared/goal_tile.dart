import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/duration_extensions.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/custom_network_image.dart';
import '../services/goal.dart';

class GoalTile extends StatelessWidget {
  final Goal goal;

  const GoalTile({super.key, required this.goal});

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
          CustomNetworkImage(
            url: goal.image,
            width: 50.r,
            height: 50.r,
          ),
          13.width,
          Expanded(
            child: Text(
              goal.title.capitalize(),
              style: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            goal.time.toFormattedString(symbol: 'HOURS'),
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
