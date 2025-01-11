import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme_colors.dart';
import 'tap_widget.dart';

class FixedDelegate extends StatelessWidget {
  final Widget? child;
  final bool showBackButtonOnScroll;
  final FixedDelegateSettings? settings;

  const FixedDelegate({
    super.key,
    this.child,
    this.settings,
    this.showBackButtonOnScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FixedPositionHeaderDelegate(
        padding: settings?.padding,
        backgroundColor: settings?.backgroundColor,
        showBackButtonOnScroll: showBackButtonOnScroll,
        maxHeight: settings?.maxHeight ?? kToolbarHeight,
        minHeight: settings?.minHeight ?? kToolbarHeight,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

class FixedPositionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool showBackButtonOnScroll;

  FixedPositionHeaderDelegate({
    this.padding,
    required this.child,
    this.backgroundColor,
    required this.minHeight,
    required this.maxHeight,
    this.showBackButtonOnScroll = false,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double currentExtent = max(minExtent, maxExtent - shrinkOffset);
    // Apply background color only when pinned (shrinkOffset is 0)
    // final bool isPinned = shrinkOffset > 0;
    // print(overlapsContent);
    // print(shrinkOffset);

    return Container(
      height: currentExtent,
      color: ThemeColor.background,
      alignment: Alignment.topCenter,
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          if (showBackButtonOnScroll)
            TapWidget(
              onTap: Navigator.of(context).maybePop,
              padding: EdgeInsets.only(
                top: 10.r * customClamp(shrinkOffset, 56.0),
                right: 12.r * customClamp(shrinkOffset, 56.0),
                bottom: 10.r * customClamp(shrinkOffset, 56.0),
              ),
              child: Icon(
                Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
                color: ThemeColor.fontBlack,
                size: 20.r * customClamp(shrinkOffset, 56.0),
              ),
            ),
          Flexible(
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  bool shouldRebuild(FixedPositionHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }

  double customClamp(double minValue, double maxValue) => (minValue / maxValue).clamp(0.0, 1.0);
}

class FixedDelegateSettings {
  final bool pinned;
  final EdgeInsets? padding;
  final Color backgroundColor;
  double? minHeight, maxHeight;

  FixedDelegateSettings({
    this.padding,
    this.pinned = true,
    double minHeight = kToolbarHeight,
    double maxHeight = kToolbarHeight,
    this.backgroundColor = ThemeColor.background,
  }) {
    if (padding != null) {
      this.maxHeight = maxHeight + padding!.vertical;
      this.minHeight = minHeight + padding!.vertical;
    } else {
      this.maxHeight = maxHeight;
      this.minHeight = minHeight;
    }
  }
}
