import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TypographyUtils on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  // TextTheme get textTheme => GoogleFonts.montserratTextTheme(theme.textTheme);
  // ColorScheme get colors => theme.colorScheme;
  TextStyle? get displayLarge => textTheme.displayLarge?.copyWith(
        fontSize: 57.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle? get displayMedium => textTheme.displayMedium?.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get displaySmall => textTheme.displaySmall?.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get headlineLarge => textTheme.headlineLarge?.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle? get headlineMedium => textTheme.headlineMedium?.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get headlineSmall => textTheme.headlineSmall?.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle? get titleLarge => textTheme.titleLarge?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle? get titleMedium => textTheme.titleMedium?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get titleSmall => textTheme.titleSmall?.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle? get labelLarge => textTheme.labelLarge?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle? get labelMedium => textTheme.labelMedium?.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle? get labelSmall => textTheme.labelSmall?.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle? get bodyLarge => textTheme.bodyLarge?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle? get bodyMedium => textTheme.bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  TextStyle? get bodySmall => textTheme.bodySmall?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );
}
