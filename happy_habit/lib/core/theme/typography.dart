import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/utils.dart';

extension TypographyUtils on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  // TextTheme get textTheme => GoogleFonts.montserratTextTheme(theme.textTheme);
  // ColorScheme get colors => theme.colorScheme;
  TextStyle? get displayLarge => textTheme.displayLarge?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 57.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get displayMedium => textTheme.displayMedium?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 28.sp,
        height: 1.25,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get displaySmall => textTheme.displaySmall?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 22.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get headlineLarge => textTheme.headlineLarge?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 32.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get headlineMedium => textTheme.headlineMedium?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 28.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get headlineSmall => textTheme.headlineSmall?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get titleLarge => textTheme.titleLarge?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
        height: 1.22,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get titleMedium => textTheme.titleMedium?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
      );

  TextStyle? get titleSmall => textTheme.titleSmall?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
        // fontFamily: Utils.kFontFamily,
        // height: 2
      );

  TextStyle? get labelLarge => textTheme.labelLarge?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get labelMedium => textTheme.labelMedium?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        height: 1.2,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get labelSmall => textTheme.labelSmall?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get bodyLarge => textTheme.bodyLarge?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 16.sp,
        height: 1.5,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get bodyMedium => textTheme.bodyMedium?.copyWith(
        fontFamily: Utils.kFontFamily,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 14.sp,
        height: 1.5,
        // fontFamily: Utils.kFontFamily,
      );

  TextStyle? get bodySmall => textTheme.bodySmall?.copyWith(
        fontFamily: Utils.kFontFamily,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 12.sp,
        height: 1.58,
        // fontFamily: Utils.kFontFamily,
      );
}
