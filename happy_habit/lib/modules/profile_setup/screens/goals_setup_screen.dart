import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/custom_outlined_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/screens/avatar_selection_screen.dart';
import 'package:happy_habit/modules/profile_setup/shared/goal_tile.dart';
import 'package:happy_habit/modules/progress/services/activity.dart';

class GoalsSetupScreen extends StatefulWidget {
  static const id = 'GoalsSetupScreen';

  const GoalsSetupScreen({super.key});

  @override
  State<GoalsSetupScreen> createState() => _GoalsSetupScreenState();
}

class _GoalsSetupScreenState extends State<GoalsSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Setup Goals',
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            CustomOutlinedButton(
              label: 'Edit Goals',
              onPressed: () {},
            ),
            15.height,
            CustomButton(
              label: 'Done',
              onPressed: () => context.pushNamed(AvatarSelectionScreen.id),
            )
          ],
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goals',
                style: context.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Edit Goals',
                style: context.bodyMedium?.copyWith(
                  color: ThemeColor.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          15.height,
          Text(
              'Lorem ipsum dolor sit amet consectetur. Nibh arcu vulputate ut elit dignissim tempus augue. Egestas accumsan ut venenatis tortor. Lacus massa augue sit enim at ac massa vel. Ullamcorper tristique gravida fames consectetur nunc feugiat sed.'),
          5.height,
          ...List.generate(
            Activity.activities.length,
            (i) => Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: GoalTile(
                activity: Activity.activities[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}
