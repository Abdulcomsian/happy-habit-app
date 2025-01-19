import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class LevelWidget extends StatelessWidget {
  final int xp, level;

  const LevelWidget({
    super.key,
    this.xp = 75,
    this.level = 10,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate xp percentage
    double xpPercentage = xp / 100.0;

    return Container(
      width: 120.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Container(
            height: 20.h,
            width: 120 * (xp / 100).w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: ThemeColor.primaryGradient.colors,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Row(
                children: [
                  Text(
                    'Lvl. $level',
                    style: context.labelSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$xp/100 XP',
                    style: context.labelMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoinWidget extends StatelessWidget {
  final int coins;

  const CoinWidget({super.key, this.coins = 200});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 20.h,
              margin: EdgeInsets.only(left: 10.w),
              padding: EdgeInsets.only(left: 24.w, right: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  10.width,
                  Text(
                    '200',
                    style: context.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SvgPicture.asset(
            AppIcons.coins,
            width: 30.r,
            height: 30.r,
          ),
        ],
      ),
    );
  }
}
