import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/typography.dart';

import 'theme_colors.dart';

class ComponentsTheme {
  static IconThemeData get iconThemeData => IconThemeData(
    color: ThemeColor.primary,
    size: 24.r,
  );

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

  static TabBarThemeData tabBarTheme(BuildContext context) => TabBarThemeData(
        dividerColor: Colors.white,
        dividerHeight: 3.h,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 3.0,
              color: ThemeColor.primary,
            ),
          ),
        ),
        unselectedLabelColor: ThemeColor.hint,
        labelStyle: context.bodyMedium?.copyWith(
          color: ThemeColor.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: context.bodyMedium?.copyWith(
          color: ThemeColor.hint,
          fontWeight: FontWeight.w500,
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

  static DialogTheme dialogTheme(BuildContext context) => DialogTheme(
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        contentTextStyle: context.bodySmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        titleTextStyle: context.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      );

  static CardTheme get cardTheme => CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      );

  static DividerThemeData get dividerTheme => DividerThemeData(
        space: 0,
        color: ThemeColor.border,
      );

  static OutlinedButtonThemeData outlinedButtonTheme(BuildContext context) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return context.bodyLarge?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              );
            } else {
              return context.bodyLarge?.copyWith(
                color: ThemeColor.primary,
                fontWeight: FontWeight.bold,
              );
            }
          }),
          minimumSize: WidgetStatePropertyAll(Size.fromHeight(48.h)),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(
                width: 1.5,
                color: Colors.grey,
              );
            } else {
              return BorderSide(
                width: 1.5,
                color: ThemeColor.primary,
              );
            }
          }),
        ),
      );

  static SearchBarThemeData searchBarTheme(BuildContext context) => SearchBarThemeData(
        elevation: WidgetStatePropertyAll(0),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 17.w),
        ),
        constraints: BoxConstraints(
          minHeight: 43.h,
        ),
        textStyle: WidgetStatePropertyAll(
          context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        hintStyle: WidgetStatePropertyAll(
          context.bodyMedium?.copyWith(
            color: ThemeColor.hint,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: WidgetStatePropertyAll(
          BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
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

  static SwitchThemeData switchThemeData(BuildContext context) => SwitchThemeData(
        splashRadius: 0.0,
        padding: EdgeInsets.zero,
        trackOutlineWidth: const WidgetStatePropertyAll(5),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return ThemeColor.primary; // Active state fill color
          }
          return Colors.white; // Inactive state fill color
        }),
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white; // Active state thumb color
          }
          return Colors.grey; // Inactive state thumb color
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return null; // No outline in active state
          }
          return Colors.transparent; // Outline color in inactive state
        }),
      );
}
