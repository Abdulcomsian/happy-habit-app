import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/extensions/int_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_switcher.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/constants/assets_path.dart';
import '../../../core/theme/theme_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  static const id = 'HelpCenterScreen';

  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Help Center',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            10.height,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: ThemeColor.primaryGradient,
                  ),
                ),
                12.width,
                Text(
                  'Help Center',
                  style: context.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            15.height,
            Text(
              'Introduction',
              style: context.titleSmall,
            ),
            15.height,
            SearchBar(
              hintText: 'Search',
              leading: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: SvgPicture.asset(
                  AppIcons.search,
                ),
              ),
            ),
            15.height,
            Expanded(
              child: ListView.separated(
                itemCount: 7,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => 15.height,
                itemBuilder: (context, i) => HelpCenterTile(
                  isVisible: i == 0,
                  title: 'What is Vivengo?',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpCenterTile extends StatelessWidget {
  final bool isVisible;
  final String title, description;

  HelpCenterTile({
    super.key,
    required this.title,
    this.isVisible = false,
    required this.description,
  }) {
    _isVisible = ValueNotifier(isVisible);
  }

  late final ValueNotifier _isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: ValueListenableBuilder(
        valueListenable: _isVisible,
        builder: (context, isVisible, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TapWidget(
                onTap: () => _isVisible.value = !_isVisible.value,
                padding: EdgeInsets.all(7.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Transform.rotate(
                      angle: isVisible ? -90.degree : 90.degree,
                      child: Icon(CupertinoIcons.forward),
                    ),
                  ],
                ),
              ),
              CustomSwitcher(
                transition: SwitcherTransition.sizeTransition,
                child: isVisible
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          12.height,
                          Divider(indent: 7.w, endIndent: 7.w),
                          12.height,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: Text(
                              description,
                              style: context.bodySmall,
                            ),
                          ),
                          7.height,
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
