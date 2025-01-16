import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/modules/profile/shared/streak_calendar.dart';

import '../../../core/shared/widgets/custom_upgrade_widget.dart';
import '../../../core/shared/widgets/root_screen.dart';
import '../shared/profile_header.dart';

class StreakScreen extends StatefulWidget {
  static const id = 'StreakScreen';

  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  DateTime startDate = DateTime(2025, 1, 1);
  DateTime endDate = DateTime(2025, 1, 31);

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Social',
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          ProfileHeader(),
          30.height,
          StreakCalendar(
            endDate: endDate,
            startDate: startDate,
          ),
          15.height,
          CustomUpgradeWidget(
            svg: AppIcons.fire,
            title: 'Streak Goal Achieved',
            buttonText: 'Collect Reward',
            description: 'Lorem ipsum dolor sit amet,',
          ),
        ],
      ),
    );
  }
}
