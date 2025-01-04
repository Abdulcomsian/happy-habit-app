import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/typography.dart';

import 'theme_colors.dart';

class ComponentsTheme {
  static ElevatedButtonThemeData elevatedButtonTheme(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          disabledForegroundColor: ThemeColor.hint,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: Colors.black.withValues(alpha: 15),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return Colors.transparent;
            },
          ),
        ),
      );

  static AppBarTheme appBarTheme(BuildContext context) => AppBarTheme(
        elevation: 0,
        centerTitle: true,
        // color: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: context.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      );

  static InputDecorationTheme inputDecorationTheme(BuildContext context) => InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
        hintStyle: context.bodyMedium?.copyWith(
          color: ThemeColor.hint,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: ThemeColor.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: ThemeColor.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: ThemeColor.border,
          ),
        ),
      );
}
