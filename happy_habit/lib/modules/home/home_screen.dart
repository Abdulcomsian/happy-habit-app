import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/duration_extensions.dart';
import 'package:happy_habit/core/extensions/int_extensions.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_outlined_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

import 'shared/sleep_chart.dart';
import 'shared/sync_watch_widget.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<bool> _isAlarmOn = ValueNotifier(false);

  @override
  void dispose() {
    _isAlarmOn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      hideHeader: true,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          20.height,
          Text(
            'Sleep Time & Wake up Time',
            style: context.titleLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          15.height,
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: ThemeColor.skyBlue,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sleep Time',
                        style: context.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      8.height,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.sleep,
                            width: 50.r,
                            height: 50.r,
                          ),
                          17.width,
                          Text(
                            Duration.zero.toFormattedString(),
                            style: context.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: ThemeColor.skyBlue,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wakeup Time',
                        style: context.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      8.height,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.wakeup,
                            width: 50.r,
                            height: 50.r,
                          ),
                          17.width,
                          Text(
                            Duration.zero.toFormattedString(),
                            style: context.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          15.height,
          Text(
            'Setup Alarm',
            style: context.titleLarge,
          ),
          15.height,
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Wakeup Time Goal',
                          style: context.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        6.height,
                        Text(
                          Duration.zero.toFormattedString(),
                          style: context.titleLarge,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Bed Time Goal',
                          style: context.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        6.height,
                        Text(
                          Duration.zero.toFormattedString(),
                          style: context.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                20.height,
                Text(
                  '08:00h Sleep',
                  style: context.titleLarge,
                ),
                20.height,
                TapWidget(
                  radius: 12.r,
                  onTap: _setIsAlarmOn,
                  color: ThemeColor.skyBlue,
                  padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 7.h),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Text(
                          'Alarm On/Off',
                          style: context.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _isAlarmOn,
                        builder: (context, isAlarmOn, _) {
                          return Transform.scale(
                            scaleY: 0.8,
                            scaleX: 0.9,
                            child: Switch(
                              value: isAlarmOn,
                              onChanged: _setIsAlarmOn,
                              activeTrackColor: ThemeColor.success,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                15.height,
                CustomOutlinedButton(
                  label: 'Save Changes',
                  onPressed: () {},
                  foregroundColor: ThemeColor.skyBlue,
                ),
              ],
            ),
          ),
          22.height,
          SyncWatchWidget(),
          15.height,
          Text(
            'Sleep Graph',
            style: context.titleLarge,
          ),
          5.height,
          Row(
            children: [
              Text(
                'Nov20 - Nov 26, 2024',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.width,
              Transform.rotate(
                angle: 90.degree,
                child: Icon(
                  CupertinoIcons.forward,
                  color: ThemeColor.fontBlack,
                ),
              ),
            ],
          ),
          15.height,
          SleepChart(),
          40.height,
        ],
      ),
    );
  }

  void _setIsAlarmOn([bool? value]) {
    _isAlarmOn.value = value ?? !_isAlarmOn.value;
  }
}
