import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/circular_bounce_loader.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/social/services/social_provider.dart';
import 'package:happy_habit/modules/social/shared/other_user_tile.dart';
import 'package:provider/provider.dart';

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
          Consumer<SocialProvider>(
            builder: (context, prov, _) {
              if (prov.isLoading) {
                return CircleBounceLoader();
              }

              if (prov.friends.isEmpty) {
                return Center(
                  child: Text(
                    'no friend to show',
                    style: context.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                itemCount: prov.friends.length,
                padding: EdgeInsets.only(bottom: 30.h),
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 10.height,
                itemBuilder: (context, i) => OtherUserTile(
                  friend: prov.friends[i],
                  xpPoints: prov.friends[i].xp,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}