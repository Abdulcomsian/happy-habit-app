import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/svg_Icon.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/modules/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/assets_path.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, prov, _) {
        return BottomNavigationBar(
          onTap: prov.changeIndex,
          currentIndex: prov.currentIndex,
          items: [
            _bottomNavigationBarItem(0, prov.currentIndex),
            _bottomNavigationBarItem(1, prov.currentIndex),
            _bottomNavigationBarItem(2, prov.currentIndex),
            _bottomNavigationBarItem(3, prov.currentIndex),
            _bottomNavigationBarItem(4, prov.currentIndex),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(int i, currentIndex) => BottomNavigationBarItem(
        label: '',
        icon: Column(
          children: [
            SvgIcon(
              _icon(i),
              color: currentIndex == i ? ThemeColor.primary : null,
            ),
            3.height,
            Container(
              height: 3.h,
              width: 12.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: currentIndex == i ? ThemeColor.primary : Colors.transparent,
              ),
            ),
          ],
        ),
      );

  String _icon(int i) {
    switch (i) {
      case 0:
        return AppIcons.moon;
      case 1:
        return AppIcons.statusUp;
      case 2:
        return AppIcons.home;
      case 3:
        return AppIcons.loading;
      default:
        return AppIcons.profile;
    }
  }
}
