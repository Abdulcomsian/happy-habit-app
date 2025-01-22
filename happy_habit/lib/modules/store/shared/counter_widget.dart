import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class CounterWidget extends StatelessWidget {
  final ValueNotifier<int> initialCount;

  const CounterWidget({
    super.key,
    required this.initialCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: ThemeColor.primary.withValues(alpha: 0.15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TapWidget(
            radius: 100,
            onTap: _decrementCount,
            padding: EdgeInsets.all(7.r),
            color: ThemeColor.primary.withValues(alpha: 0.3),
            child: Icon(
              CupertinoIcons.minus,
              size: 18.r,
            ),
          ),
          12.width,
          ValueListenableBuilder(
              valueListenable: initialCount,
              builder: (context, count, _) {
                return Text(
                  count.toString(),
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                );
              }),
          12.width,
          TapWidget(
            radius: 100,
            color: ThemeColor.primary,
            padding: EdgeInsets.all(7.r),
            onTap: () => initialCount.value++,
            child: Icon(
              size: 18.r,
              CupertinoIcons.add,
              color: CupertinoColors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _decrementCount() {
    if (initialCount.value > 0) {
      initialCount.value--;
    }
  }
}
