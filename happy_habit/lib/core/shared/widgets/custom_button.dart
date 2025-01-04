import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/color_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color? color;
  final Widget? icon;
  final VoidCallback? onPressed;


  const CustomButton({
    super.key,
    this.icon,
    this.color,
    this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeColor.primaryGradient,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size.fromHeight(48.h),
        ),
        label: Text(
          label,
          style: context.bodyLarge!.copyWith(
            height: 1,
            color: _foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool get _isDisable => onPressed == null;

  Color? get _foregroundColor => color == null ? Colors.white : color?.contrastColor;
}
