import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile/screens/setting_screen.dart';

import '../../../core/constants/assets_path.dart';

class ProfileHeader extends StatelessWidget {
  final bool isAppUser;

  const ProfileHeader({
    super.key,
    this.isAppUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(),
          14.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                Text(
                  'username',
                  style: context.titleMedium?.copyWith(
                    color: ThemeColor.hint,
                  ),
                ),
                12.height,
                Row(
                  spacing: 12.w,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconPoints(
                      svg: AppIcons.xp,
                      points: 55,
                    ),
                    IconPoints(
                      svg: AppIcons.coins,
                      points: 55,
                    ),
                    IconPoints(
                      points: 50,
                      svg: AppIcons.fire,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isAppUser)
            TapWidget(
              padding: EdgeInsets.all(3.r),
              onTap: () => context.pushNamed(SettingScreen.id),
              child: SvgPicture.asset(
                AppIcons.settings,
              ),
            ),
        ],
      ),
    );
  }
}

class IconPoints extends StatelessWidget {
  final String svg;
  final int points;

  const IconPoints({
    super.key,
    required this.svg,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svg,
          width: 24.r,
          height: 24.r,
        ),
        Text(
          points.toString(),
          style: context.titleMedium,
        ),
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final double size;
  final bool isOnline, removeBorder;

  const ProfileAvatar({
    super.key,
    this.size = 86,
    this.isOnline = false,
    this.removeBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    if (removeBorder) {
      return _avatar;
    }

    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ThemeColor.primary, width: 2),
      ),
      child: _avatar,
    );
  }

  Widget get _avatar => Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: size.r,
            height: size.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeColor.primary,
              image: DecorationImage(
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                image: AssetImage(DummyIcons.man),
              ),
            ),
          ),
          if (isOnline)
            Icon(
              size: 10.r,
              Icons.circle,
              color: ThemeColor.success,
            ),
        ],
      );
}
