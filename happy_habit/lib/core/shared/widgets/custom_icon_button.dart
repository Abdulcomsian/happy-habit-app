import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';

import '../../theme/theme_colors.dart';

class CustomIconButton extends StatelessWidget {
  final String svg;
  final VoidCallback? onTap;

  const CustomIconButton({
    super.key,
    this.onTap,
    required this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      radius: 100,
      onTap: onTap,
      color: Colors.white,
      padding: EdgeInsets.all(10.r),
      borderColor: ThemeColor.primary,
      child: SvgPicture.asset(
        svg,
        width: 24.r,
        height: 24.r,
      ),
    );
  }
}
