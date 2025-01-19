import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/svg_Icon.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile/screens/streak_screen.dart';

import '../../achievements/screens/achievements_screen.dart';
import '../../social/screens/social_screen.dart';
import '../../store/screens/store_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: InputBorder.none,
      backgroundColor: ThemeColor.primary,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: ThemeColor.primaryGradient.colors.reversed.toList(),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kToolbarHeight.height,
            Padding(
              padding: EdgeInsets.fromLTRB(20.r, 20.r, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Image.asset(
                  BrandIcons.icon,
                  width: 53.r,
                  height: 53.r,
                ),
              ),
            ),
            10.height,
            Divider(color: Colors.white, height: 40.h),
            DrawerItem(
              label: 'Social',
              svg: AppIcons.social,
              onTap: () => context.pushNamed(SocialScreen.id),
            ),
            DrawerItem(
              onTap: () {},
              label: 'Character',
              svg: AppIcons.editUser,
            ),
            DrawerItem(
              onTap: () {},
              label: 'Wallpapers',
              svg: AppIcons.brush,
            ),
            DrawerItem(
              label: 'Stores',
              svg: AppIcons.addShop,
              onTap: () => context.pushNamed(StoreScreen.id),
            ),
            DrawerItem(
              label: 'Streaks',
              svg: AppIcons.streak,
              onTap: () => context.pushNamed(StreakScreen.id),
            ),
            DrawerItem(
              label: 'Achievements',
              svg: AppIcons.trophy,
              onTap: () => context.pushNamed(AchievementsScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String svg, label;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.svg,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          SvgIcon(
            svg,
            color: Colors.white,
          ),
          12.width,
          Text(
            label,
            style: context.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
