import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class TapWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? overlayColor;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final double? radius, elevation, borderWidth;
  final Color? color, borderColor, splashColor, shadowColor;

  const TapWidget({
    super.key,
    this.onTap,
    this.color,
    this.radius,
    this.padding,
    this.elevation,
    this.onLongPress,
    this.borderColor,
    this.splashColor,
    this.shadowColor,
    this.borderWidth,
    required this.child,
    this.overlayColor = ThemeColor.primaryShade,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: _elevation,
      shadowColor: shadowColor,
      color: color ?? Colors.transparent,
      borderRadius: BorderRadius.circular(
        radius ?? 0,
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        onLongPress: onLongPress,
        highlightColor: overlayColor?.withAlpha(30),
        borderRadius: BorderRadius.circular(
          radius ?? 0,
        ),
        child: borderColor != null
            ? Container(
                padding: padding ?? EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    radius ?? 0,
                  ),
                  border: Border.all(
                    color: borderColor!,
                    width: borderWidth ?? 1.5,
                  ),
                ),
                child: child,
              )
            : Padding(
                padding: padding ?? EdgeInsets.zero,
                child: child,
              ),
      ),
    );
  }

  double get _elevation {
    if (elevation != null) {
      return elevation!;
    } else if (shadowColor != null) {
      return 1;
    } else {
      return 0;
    }
  }
}
