import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/social/shared/friend_tile.dart';

class FriendsContent extends StatelessWidget {
  const FriendsContent({super.key});

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
                'Friends',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Add Friends',
                style: context.bodyMedium?.copyWith(
                  color: ThemeColor.primary,
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
            itemBuilder: (context, i) => FriendTile(
              xpPoints: 55,
            ),
          ),
        ],
      ),
    );
  }
}