import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/modals/custom_dialog.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/auth/screens/login_screen.dart';
import 'package:happy_habit/modules/profile/screens/notifications_screen.dart';
import 'package:happy_habit/modules/profile/shared/profile_header.dart';

import 'about_us_screen.dart';
import 'edit_profile_screen.dart';
import 'help_center_screen.dart';

class SettingScreen extends StatelessWidget {
  static const id = 'SettingScreen';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Settings',
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          10.height,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset(
                  AppIcons.bgDots,
                  width: 154.w,
                  height: 118.h,
                ),
                Column(
                  children: [
                    20.height,
                    ProfileAvatar(),
                    20.height,
                    Text(
                      'Username',
                      style: context.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    10.height,
                    CustomButton(
                      label: 'Edit Profile',
                      icon: Icon(Icons.mode_edit, color: Colors.white),
                      onPressed: () => context.pushNamed(EditProfileScreen.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.height,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SettingTile(
                  label: 'Notification',
                  color: Color(0xff0ACD00),
                  svg: AppIcons.notification,
                  onTap: () => context.pushNamed(NotificationsScreen.id),
                ),
                Divider(endIndent: 75.w),
                SettingTile(
                  label: 'Rate App',
                  svg: AppIcons.star,
                  color: Color(0xffFF006B),
                ),
                Divider(endIndent: 75.w),
                SettingTile(
                  svg: AppIcons.like,
                  label: 'Share with Friends',
                ),
                Divider(endIndent: 75.w),
                SettingTile(
                  label: 'About US',
                  svg: AppIcons.danger,
                  color: Color(0xff0ACD00),
                  onTap: () => context.pushNamed(AboutUsScreen.id),
                ),
                Divider(endIndent: 75.w),
                SettingTile(
                  label: 'Help Center',
                  svg: AppIcons.calling,
                  color: Color(0xffFF006B),
                  onTap: () => context.pushNamed(HelpCenterScreen.id),
                ),
                Divider(endIndent: 75.w),
                SettingTile(
                  isLogout: true,
                  label: 'Logout',
                  svg: AppIcons.logout,
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final response = await showDialog(
      context: context,
      builder: (context) => CustomDialog(
        actionLabel: 'Logout',
        svg: AppIcons.happyStar,
        title: 'Do you want to logout?',
        message: "We are looking forward to see you soon!",
        onAction: () => Navigator.pop(context, true),
        onSecondaryAction: () => Navigator.pop(context, false),
      ),
    ) ?? false;

    if (response && context.mounted) {
      context.goNamed(LoginScreen.id);
    }
  }
}

class SettingTile extends StatelessWidget {
  final Color color;
  final bool isLogout;
  final String svg, label;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    this.onTap,
    required this.svg,
    required this.label,
    this.isLogout = false,
    this.color = ThemeColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: onTap ?? () {},
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: SvgPicture.asset(
              svg,
            ),
          ),
          16.width,
          Expanded(
            child: Text(
              label,
              style: context.bodyMedium?.copyWith(
                color: color,
              ),
            ),
          ),
          if (!isLogout) Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}
