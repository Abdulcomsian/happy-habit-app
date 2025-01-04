import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

/// calculate contrast color based on luminance.
extension Luminance on Color {
  Color get contrastColor => computeLuminance() > 0.5 ? ThemeColor.fontBlack : ThemeColor.secondary;

  Color applyContrastColor(Color darkColor, lightColor) {
    Color color = computeLuminance() > 0.5 ? darkColor : lightColor;
    return color;
  }
}