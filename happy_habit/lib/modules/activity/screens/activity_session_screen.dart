import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_icon_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/activity/shared/custom_slider.dart';

import 'activity_result_screen.dart';

class ActivitySessionScreen extends StatefulWidget {
  static const id = 'ActivitySessionScreen';

  final Duration duration;

  const ActivitySessionScreen({super.key, required this.duration});

  @override
  State<ActivitySessionScreen> createState() => _ActivitySessionScreenState();
}

class _ActivitySessionScreenState extends State<ActivitySessionScreen> with WidgetsBindingObserver {
  late Timer _timer;
  late final ValueNotifier<Duration> _remainingDuration;
  final ValueNotifier<bool> _isPaused = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _remainingDuration = ValueNotifier(widget.duration);
    _startTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  void _updateTimer(Timer timer) {
    if (!_isPaused.value) {
      if (_remainingDuration.value.inSeconds > 0) {
        _remainingDuration.value -= Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  void _handleAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in background, save remaining time if needed
      _updateTimer(_timer);
    } else if (state == AppLifecycleState.resumed) {
      // App is back in foreground, you may want to update the UI if needed
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _handleAppLifecycleState(state);
  }

  @override
  void dispose() {
    _timer.cancel();
    _isPaused.dispose();
    _remainingDuration.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Focus Timer',
      action: SvgPicture.asset(AppIcons.headphones),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 28.h),
        child: ValueListenableBuilder(
          valueListenable: _remainingDuration,
          builder: (context, duration, _) {
            double percentage = duration.inSeconds / widget.duration.inSeconds;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientSlider(
                      percentage: percentage,
                    ),
                    Text(
                      '${(percentage * 100).toStringAsFixed(2)}%',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      onTap: _closeTimer,
                      svg: AppIcons.closeCircle,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isPaused,
                      builder: (context, isPaused, _) {
                        return CustomIconButton(
                          // onTap: isPaused ? _playTimer : _pauseTimer,
                          onTap: () => _isPaused.value = !_isPaused.value,
                          svg: isPaused ? AppIcons.play : AppIcons.pause,
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
      child: Column(
        children: [
          10.height,
          AspectRatio(
            aspectRatio: 1.sw / 399.h,
            child: Image.asset(
              DummyIcons.activity,
              fit: BoxFit.cover,
            ),
          ),
          44.height,
          Divider(color: ThemeColor.hint, indent: 80.w, endIndent: 80.w),
          10.height,
          ValueListenableBuilder(
            valueListenable: _remainingDuration,
            builder: (context, duration, _) {
              String hours = duration.inHours.toString().padLeft(2, '0');
              String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
              String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimer(hours, 'hours'),
                  _buildTimer(minutes, 'minutes'),
                  _buildTimer(seconds, 'seconds'),
                ],
              );
            },
          ),
          10.height,
          Divider(color: ThemeColor.hint, indent: 80.w, endIndent: 80.w),
        ],
      ),
    );
  }

  Widget _buildTimer(String value, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: context.titleMedium),
          Text(
            label,
            style: context.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _closeTimer() {
    _timer.cancel();
    context.pushReplacementNamed(ActivityResultScreen.id);
  }
}
