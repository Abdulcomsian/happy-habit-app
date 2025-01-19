import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../shared/friend_tile.dart';

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

    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.desireIndex ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListView.separated(
                    itemCount: 3,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    separatorBuilder: (context, index) => 10.height,
                    itemBuilder: (context, index) => FriendTile(),
                  ),
                  ListView.separated(
                    itemCount: 3,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    separatorBuilder: (context, index) => 10.height,
                    itemBuilder: (context, index) => FriendTile(
                      isFriend: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
