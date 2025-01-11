import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../shared/friend_tile.dart';

class SocialScreen extends StatelessWidget {
  static const id = 'SocialScreen';

  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Social',
      crossAxisAlignment: CrossAxisAlignment.start,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            Text(
              'Friends',
              style: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            15.height,
            SearchBar(
              hintText: 'Search',
              leading: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: SvgPicture.asset(
                  AppIcons.search,
                ),
              ),
            ),
            15.height,
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.only(bottom: 20.h),
                separatorBuilder: (context, index) => 10.height,
                itemBuilder: (context, index) => FriendTile(
                  isFriend: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
