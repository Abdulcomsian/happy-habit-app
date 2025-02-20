import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/providers.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/shared/widgets/custom_outlined_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile_setup/screens/character_selection_screen.dart';
import 'package:happy_habit/modules/profile_setup/services/profile_setup_provider.dart';
import 'package:happy_habit/modules/profile_setup/shared/goal_tile.dart';
import 'package:provider/provider.dart';

class GoalsSetupScreen extends StatefulWidget {
  static const id = '/GoalsSetupScreen';

  const GoalsSetupScreen({super.key});

  @override
  State<GoalsSetupScreen> createState() => _GoalsSetupScreenState();
}

class _GoalsSetupScreenState extends State<GoalsSetupScreen> {
  final _prov = serviceLocator<ProfileSetupProvider>();

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _getGoals();
  }

  void _getGoals() async {
    await _prov.getGoals();
    _isLoading.value = false;
  }

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Setup Goals',
      isLoading: _isLoading,
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
              onPressed: _setupGoals,
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
              // Text(
              //   'Edit Goals',
              //   style: context.bodyMedium?.copyWith(
              //     color: ThemeColor.primary,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
            ],
          ),
          15.height,
          Text(
              'Take charge of your daily routine by choosing how much time you want to dedicate to each key habit. Setting clear goals for sleep, screen use, workouts and focused  time for a meaningful activity helps you stay on track and build a healthier, more balanced lifestyle.'),
          5.height,
          // ...List.generate(
          // Activity.activities.length,
          // (i) => Padding(
          //   padding: EdgeInsets.only(top: 10.h),
          //   child: GoalTile(
          //     activity: Activity.activities[i],
          //   ),
          // ),
          // ),
          Consumer<ProfileSetupProvider>(
            builder: (context, prov, _) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: prov.goals.length,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 10.height,
                itemBuilder: (context, i) => GoalTile(
                  goal: prov.goals[i],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _setupGoals() async {
    _isLoading.value = true;
    final isSetup = await _prov.setGoals();
    _isLoading.value = false;
    if (isSetup && mounted) context.goNamed(CharacterSelectionScreen.id);
  }
}
