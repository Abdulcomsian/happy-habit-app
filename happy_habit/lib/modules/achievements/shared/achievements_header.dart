import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/custom_back_button.dart';
import '../../../core/shared/widgets/tap_widget.dart';
import '../../../core/theme/theme_colors.dart';

class AchievementsHeader extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;

  const AchievementsHeader({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: (233 - kToolbarHeight).h,
      backgroundColor: ThemeColor.primary,
      leading: CustomBackButton(
        color: Colors.white,
      ),
      title: Text(
        'Achievements',
        style: context.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            gradient: ThemeColor.primaryGradient,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Achievements',
                style: context.headlineSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
              10.height,
              TapWidget(
                radius: 20,
                color: Colors.black.withValues(alpha: 0.2),
                padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 7.h),
                child: Text(
                  'Award 1/10',
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              40.height,
            ],
          ),
        ),
      ),
      bottom: TabBar(
        onTap: (value) => selectedIndex.value = value,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.all(5.r),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 5.0,
              color: Colors.white,
            ),
          ),
        ),
        labelStyle: context.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: context.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Text('Achievements'),
          Text('Awards'),
        ],
      ),
    );
  }
}
