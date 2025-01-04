import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String svg;
  final BoxFit fit;
  final Color? color;
  final double? width, height;

  const SvgIcon(
      this.svg, {
        super.key,
        this.color,
        this.width,
        this.height,
        this.fit = BoxFit.contain,
      });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      fit: fit,
      width: width,
      height: height,
      colorFilter: _colorFilter,
    );
  }

  ui.ColorFilter? get _colorFilter {
    if (color == null) return null;
    return ColorFilter.mode(
      color!,
      BlendMode.srcIn,
      // BlendMode.srcOver,
    );
  }
}