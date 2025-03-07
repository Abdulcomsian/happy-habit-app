import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile/shared/leaderboard_content.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/widgets/circular_bounce_loader.dart';
import '../services/social_provider.dart';
import '../shared/other_user_tile.dart';

class SocialScreen extends StatefulWidget {
  static const id = 'SocialScreen';

  final int? desireIndex;

  const SocialScreen({super.key, required this.desireIndex});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.desireIndex ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: RootScreen(
        title: 'Social',
        crossAxisAlignment: CrossAxisAlignment.start,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              labelStyle: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: context.bodyLarge?.copyWith(
                color: ThemeColor.hint,
                fontWeight: FontWeight.bold,
              ),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: 'Friends'),
                Tab(text: 'pending requests'),
                Tab(text: 'Leaderboard'),
              ],
            ),
            15.height,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SearchBar(
                hintText: 'Search',
                leading: Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: SvgPicture.asset(
                    AppIcons.search,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<SocialProvider>(
                builder: (context, prov, _) {
                  return TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      if (prov.isLoading)
                        CircleBounceLoader()
                      else if (prov.friends.isEmpty)
                        Center(
                          child: Text(
                            'no friends to show',
                            style: context.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          itemCount: prov.friends.length,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          separatorBuilder: (context, index) => 10.height,
                          itemBuilder: (context, i) => OtherUserTile(
                            friend: prov.friends[i],
                          ),
                        ),
                      if (prov.isLoading)
                        CircleBounceLoader()
                      else if (prov.pendingRequest.isEmpty)
                        Center(
                          child: Text(
                            'no pending request to show',
                            style: context.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        ListView.separated(
                          itemCount: prov.pendingRequest.length,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          separatorBuilder: (context, index) => 10.height,
                          itemBuilder: (context, i) => OtherUserTile(
                            isFriend: false,
                            friend: prov.pendingRequest[i],
                          ),
                        ),
                      LeaderboardContent(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
