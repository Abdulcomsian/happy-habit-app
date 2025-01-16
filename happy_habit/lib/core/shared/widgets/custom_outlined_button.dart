import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final Color foregroundColor;
  final VoidCallback? onPressed;

  const CustomOutlinedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.foregroundColor = ThemeColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        side: BorderSide(
          width: 1.5,
          color: _foregroundColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(
        label,
        style: context.bodyLarge?.copyWith(
          color: _foregroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color get _foregroundColor {
    if (onPressed == null) {
      return ThemeColor.graphiteGrey;
    } else {
      return foregroundColor;
    }
  }
}
