import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class ProfileTabBar extends StatelessWidget {
  final ValueNotifier<int> currentIndex;

  ProfileTabBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 3,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _items.length,
              (i) => InkWell(
                onTap: () => currentIndex.value = i,
                child: ValueListenableBuilder(
                  valueListenable: currentIndex,
                  builder: (context, current, _) {
                    final selected = current == i;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: selected ? ThemeColor.primary:Colors.transparent,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(7.r),
                      child: Text(
                        _items[i],
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selected ? ThemeColor.primary : ThemeColor.hint,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final _items = [
    'Activity',
    'Goals',
    'Friends',
    'Leaderboard',
  ];
}
