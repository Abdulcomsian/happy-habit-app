import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/modules/achievements/shared/achievement_tile.dart';
import 'package:happy_habit/modules/achievements/shared/achievements_header.dart';

import '../services/achievement.dart';

class AchievementsScreen extends StatefulWidget {
  static const id = 'AchievementsScreen';

  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.background,
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            AchievementsHeader(
              selectedIndex: _selectedIndex,
            ),
            ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, selectedIndex, _) {
                  return SliverPadding(
                    padding: EdgeInsets.all(20.r),
                    sliver: /*selectedIndex != 0
                        ? SizedBox.shrink().sliver()
                        : */
                        SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: selectedIndex == 1 ? 3 : 2,
                        mainAxisSpacing: 13.r,
                        crossAxisSpacing: 13.r,
                        childAspectRatio: selectedIndex == 1 ? 83.w / 150.h : 161.w / 180.h,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: Achievement.achievements.length,
                        (context, i) => Opacity(
                          opacity: i > 6 ? 0.3 : 1,
                          child: AchievementTile(
                            isAward: selectedIndex == 1,
                            achievement: Achievement.achievements[i],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
