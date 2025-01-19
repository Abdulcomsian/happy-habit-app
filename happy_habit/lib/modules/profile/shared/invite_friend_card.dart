import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/social/screens/social_screen.dart';

class InviteFriendCard extends StatelessWidget {
  const InviteFriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: ThemeColor.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invite Friends',
            style: context.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            'Invite your friends and earn coins and exclusive items.',
            style: context.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          10.height,
          Flex(
            direction: Axis.horizontal,
            children: [
              TapWidget(
                radius: 4.r,
                onTap: () => context.pushNamed(SocialScreen.id, extra: {
                  'desireIndex': 1,
                }),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Text(
                  'See Requests',
                  style: context.bodyMedium?.copyWith(
                    color: ThemeColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              15.width,
              Expanded(
                child: TapWidget(
                  radius: 4.r,
                  onTap: () {},
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Text(
                    'Invite your friends',
                    style: context.bodyMedium?.copyWith(
                      color: ThemeColor.primary,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
