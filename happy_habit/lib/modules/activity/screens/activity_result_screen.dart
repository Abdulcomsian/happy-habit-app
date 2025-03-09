import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/duration_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class ActivityResultScreen extends StatelessWidget {
  static const id = 'ActivityResultScreen';

  final int xp, coins;
  final Duration duration;

  const ActivityResultScreen({
    super.key,
    required this.xp,
    required this.coins,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      // hideHeader: true,
      title: 'Focus Timer',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.happyStar,
            width: 150.r,
            height: 150.r,
          ),
          Text(
            'Congratulations',
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          50.height,
          Text(
            'activity name'.toUpperCase(),
            style: context.titleLarge,
          ),
          20.height,
          Text(
            'Duration',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            color: ThemeColor.fontBlack,
            indent: 60.w,
            height: 28.h,
            endIndent: 60.w,
          ),
          duration.toWidget(context),
          Divider(
            color: ThemeColor.fontBlack,
            indent: 60.w,
            height: 28.h,
            endIndent: 60.w,
          ),
          Text(
            'XP + Coins earned',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          10.height,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                xp.toString(),
                style: context.headlineLarge,
              ),
              5.width,
              SvgPicture.asset(
                AppIcons.xp,
                width: 42.r,
                height: 42.r,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                coins.toString(),
                style: context.headlineLarge,
              ),
              5.width,
              SvgPicture.asset(
                AppIcons.coins,
                width: 42.r,
                height: 42.r,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
