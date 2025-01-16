import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/shared/widgets/user_score_widgets.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';

import '../../../core/shared/widgets/custom_outlined_button.dart';

class ProgressScreen extends StatelessWidget {
  static const id = 'ProgressScreen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            AppAssets.bg,
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 60.h,
            width: 1.sw,
            height: 1.sh,
            child: Column(
              children: [
                Image.asset(
                  DummyIcons.avatar,
                  width: 198.w,
                  height: 594.h,
                  fit: BoxFit.cover,
                ),
                30.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomOutlinedButton(
                    onPressed: () {},
                    // onPressed: () => context.pushNamed(ProgressTrackingScreen.id),
                    label: 'Progress Tracking',
                    foregroundColor: ThemeColor.fontBlack,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 20.w,
            top: kToolbarHeight.h,
            child: TapWidget(
              onTap: Scaffold.of(context).openDrawer,
              child: SvgPicture.asset(
                AppIcons.drawer,
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: kToolbarHeight.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LevelWidget(),
                5.height,
                CoinWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
