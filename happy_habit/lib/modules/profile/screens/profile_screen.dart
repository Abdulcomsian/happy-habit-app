import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/modules/profile/shared/activity_content.dart';
import 'package:happy_habit/modules/profile/shared/friends_content.dart';
import 'package:happy_habit/modules/profile/shared/goals_content.dart';
import 'package:happy_habit/modules/profile/shared/invite_friend_card.dart';
import 'package:happy_habit/modules/profile/shared/leaderboard_content.dart';

import '../../../core/shared/widgets/fixed_header_delegate.dart';
import '../../../core/theme/theme_colors.dart';
import '../shared/profile_header.dart';
import 'streak_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'ProfileScreen';

  final bool isAppUser;

  const ProfileScreen({super.key, this.isAppUser = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final _currentIndex = ValueNotifier(0);

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: RootScreen(
        title: 'Social',
        applySafeAreaSpace: false,
        hideHeader: widget.isAppUser,
        backgroundColor: ThemeColor.background,
        child: CustomScrollView(
          slivers: [
            FixedDelegate(
              settings: FixedDelegateSettings(
                minHeight: widget.isAppUser ? (25 + kToolbarHeight).h : 10.h,
                maxHeight: widget.isAppUser ? (25 + kToolbarHeight).h : 10.h,
              ),
              child: SizedBox.shrink(),
            ),
            FixedDelegate(
              settings: FixedDelegateSettings(minHeight: 86.h),
              child: ProfileHeader(
                isAppUser: widget.isAppUser,
              ),
            ),
            13.height.sliver(),
            if (!widget.isAppUser)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 15.h),
                sliver: CustomButton(
                  onPressed: () {},
                  label: 'Add Friend',
                ).sliver(),
              ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: OutlinedButton(
                onPressed: () {},
                child: Text(widget.isAppUser ? 'Add Seasonal Avatar' : 'Chat'),
              ).sliver(),
            ),
            13.height.sliver(),
            if (widget.isAppUser)
              SliverPadding(
              padding: EdgeInsets.only(bottom: 10.h),
              sliver: InviteFriendCard().sliver(),
            ),
            FixedDelegate(
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                onTap: (value) => _currentIndex.value = value,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                tabs: [
                  Tab(text: 'Activity'),
                  Tab(text: 'Goals'),
                  Tab(text: 'Friends'),
                  Tab(text: 'Leaderboard'),
                ],
              ),
            ),
            10.height.sliver(),
            ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, index, child) {
                switch (index) {
                  case 0:
                    return ActivityContent();
                  case 1:
                    return GoalsContent();
                  case 2:
                    return FriendsContent();
                  case 3:
                  default:
                    return LeaderboardContent();
                }
              },
            ).sliver(),
            // SizedBox(
            //   height: 1.sh,
            //   child: TabBarView(
            //     children: [
            //       ActivityContent(),
            //       GoalsContent(),
            //       FriendsContent(),
            //       LeaderboardContent(),
            //     ],
            //   ),
            // ).sliver(),
          ],
        ),
      ),
    );
  }
}
