import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_back_button.dart';
import 'package:happy_habit/core/shared/widgets/fullscreen_.dart';

import '../../constants/asset_paths.dart';

class RootScreen extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool hideHeader;
  final VoidCallback? onPop;
  final Color? backgroundColor;
  final ValueNotifier isLoading;
  final bool applySafeAreaSpace;
  final bool? resizeToAvoidBottomInset;
  final Widget? action, leading, bottomNavigationBar;

  // final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;

  RootScreen({
    super.key,
    this.title,
    this.onPop,
    this.action,
    this.leading,
    // this.padding,
    required this.child,
    this.backgroundColor,
    this.hideHeader = false,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    ValueNotifier<bool>? isLoading,
    this.applySafeAreaSpace = true,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : isLoading = isLoading ?? ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        fit: StackFit.loose,
        children: [
          if (backgroundColor == null)
            Image.asset(
              AppAssets.bg,
              width: 1.sw,
              height: 1.sh,
              fit: BoxFit.cover,
            ),
          Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              if (!hideHeader)
                AppBar(
                  title: Text(title ?? ''),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: leading ?? CustomBackButton(
                      onPressed: onPop,
                    ),
                  ),
                  actions: [action ?? SizedBox.shrink(), 20.width],
                ) else if (applySafeAreaSpace) kToolbarHeight.height,
              Expanded(
                child: child,
              ),
              if (MediaQuery.of(context).viewInsets.bottom < 10)
                bottomNavigationBar ?? const SizedBox.shrink(),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, loading, child) =>
                loading ? const FullScreenLoader() : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
