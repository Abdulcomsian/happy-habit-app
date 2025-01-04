import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/shared/widgets/custom_back_button.dart';
import 'package:happy_habit/core/shared/widgets/fullscreen_.dart';

import '../../constants/assets_path.dart';

class RootScreen extends StatelessWidget {
  final Widget child;
  final String? title;
  final ValueNotifier isLoading;
  final Widget? bottomNavigationBar;

  // final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;

  RootScreen({
    super.key,
    this.title,
    // this.padding,
    required this.child,
    this.bottomNavigationBar,
    ValueNotifier<bool>? isLoading,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : isLoading = isLoading ?? ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            AppAssets.bg,
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              AppBar(
                title: Text(title ?? ''),
                leading: Padding(
                  padding: EdgeInsets.only(left: 18.w),
                  child: CustomBackButton(),
                ),
              ),
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
