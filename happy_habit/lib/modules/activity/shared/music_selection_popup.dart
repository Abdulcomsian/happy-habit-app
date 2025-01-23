import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';

import '../../../core/constants/asset_paths.dart';

class MusicSelectionPopup extends StatelessWidget {
  MusicSelectionPopup({super.key});

  final _musicFlavors = [
    AppIcons.music,
    AppIcons.piano,
    AppIcons.rain,
    AppIcons.flower,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 311.r,
        height: 300.r,
        child: Padding(
          padding: EdgeInsets.all(40.r),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: _musicFlavors.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 30.h,
              crossAxisSpacing: 45.w,
            ),
            itemBuilder: (context, i) => SizedBox(
              width: 92.r,
              height: 92.r,
              child: TapWidget(
                radius: 100,
                padding: EdgeInsets.all(12.r),
                color: ThemeColor.backgroundV2,
                onTap: () => Navigator.pop(context),
                child: Center(
                  child: SvgPicture.asset(
                    _musicFlavors[i],
                    width: 50.r,
                    height: 50.r,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
