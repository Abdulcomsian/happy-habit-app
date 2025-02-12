import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/extensions/string_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/logger.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/activity/shared/activity_selection_popup.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/services/providers.dart';
import '../../../core/shared/widgets/custom_duration_picker.dart';
import '../../../core/shared/widgets/root_screen.dart';
import '../../navigation/navigation_provider.dart';
import '../shared/start_button.dart';
import 'activity_session_screen.dart';

class ActivitySetupScreen extends StatefulWidget {
  static const id = 'ActivitySetupScreen';

  const ActivitySetupScreen({super.key});

  @override
  State<ActivitySetupScreen> createState() => _ActivitySetupScreenState();
}

class _ActivitySetupScreenState extends State<ActivitySetupScreen> {
  late final ValueNotifier<String> _selectedActivity;
  final ValueNotifier<Duration> _duration = ValueNotifier(Duration.zero);

  final _controller = FixedExtentScrollController();

  // final ValueNotifier<Duration> _duration = ValueNotifier(Duration(minutes: 15));

  @override
  void initState() {
    super.initState();
    _selectedActivity = ValueNotifier(_activities.first);
  }

  @override
  void dispose() {
    _duration.dispose();
    _controller.dispose();
    _selectedActivity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      onPop: () => serviceLocator<NavigationProvider>().changeIndex(2),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StartButton(
              onTap: () {
                // if (_duration.value.inSeconds >= 900) {
                context.pushNamed(ActivitySessionScreen.id, extra: {
                  'duration': _duration.value,
                  'activity': _selectedActivity.value,
                });
                // } else {
                //   AppToast.show('Activity session duration should be greater than 15 minutes');
                // }
              },
            ),
          ],
        ),
      ),
      child: ListView(
        // shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Focus Timer',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      size: 24.r,
                      color: ThemeColor.vividGreen,
                    ),
                    Text(
                      ' l ',
                      style: context.headlineLarge?.copyWith(
                        height: 1,
                        color: ThemeColor.border,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SvgPicture.asset(
                      AppIcons.loading,
                      width: 24.r,
                      height: 24.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
          15.height,
          SizedBox(
            height: 110.h,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 100.h,
              controller: _controller,
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: _onSelectedItemChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: _activities.length,
                builder: (context, i) => ActivityTile(
                  activity: _activities[i],
                ),
              ),
            ),
          ),
          5.height,
          TextButton.icon(
            label: Text('Add New'),
            icon: Icon(CupertinoIcons.add_circled),
            onPressed: () => _onAddActivity(context),
          ),
          40.height,
          ValueListenableBuilder(
            valueListenable: _duration,
            builder: (context, duration, _) {
              return CustomDurationPicker(
                initialDuration: duration,
                onChanged: (val) => _duration.value = val,
              );
            },
          ),
        ],
      ),
    );
  }

  final List<String> _activities = [
    'meditation',
    'read',
    'study',
    'workout',
  ];

  void _onSelectedItemChanged(int i) {
    _selectedActivity.value = _activities[i];
    Logger.logInfo('_selectedActivity: ${_selectedActivity.value}');
  }

  Future<void> _onAddActivity(BuildContext context) async {
    final response = await showDialog<String?>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return ActivitySelectionPopup();
      },
    );

    if (response != null) {
      // _activities.add(response);
      _activities.insert(0, response);
      _selectedActivity.value = response;
      setState(() {});

      // Animate to the last index
      double offset = _controller.position.minScrollExtent;  // Get the last scroll position
      _controller.animateTo(offset, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}

class ActivityTile extends StatelessWidget {
  final String activity;

  const ActivityTile({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      decoration: BoxDecoration(
        color: ThemeColor.vividGreen,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            activity.capitalize(),
            style: context.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/$activity.svg',
            width: 86.r,
            height: 86.r,
          )
        ],
      ),
    );
  }
}
