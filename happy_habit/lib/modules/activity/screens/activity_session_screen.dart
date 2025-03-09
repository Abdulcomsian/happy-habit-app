import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/services/logger.dart';
import 'package:happy_habit/core/shared/widgets/custom_icon_button.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/activity/shared/custom_slider.dart';
import 'package:happy_habit/modules/activity/shared/give_up_popup.dart';

import '../../../core/shared/helper_functions/media/music_services.dart';
import '../shared/avatar_animation_widget.dart';
import '../shared/music_selection_popup.dart';
import 'activity_result_screen.dart';

class ActivitySessionScreen extends StatefulWidget {
  static const id = 'ActivitySessionScreen';

  final String activity;
  final Duration duration;

  const ActivitySessionScreen({
    super.key,
    required this.activity,
    required this.duration,
  });

  @override
  State<ActivitySessionScreen> createState() => _ActivitySessionScreenState();
}

class _ActivitySessionScreenState extends State<ActivitySessionScreen> with WidgetsBindingObserver {
  late Timer _timer;
  final ValueNotifier<bool> _isActivityPaused = ValueNotifier(false);
  final ValueNotifier<Duration> _sessionDuration = ValueNotifier(Duration.zero);
  final ValueNotifier<MusicFlavors> _selectedMusic = ValueNotifier(MusicFlavors.none);

  MusicFlavors? _previousMusic;

  int xp = 0, coins = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Music.play(AppMusics.music);
    WidgetsBinding.instance.addObserver(this);
  }

  void _updateTimer(Timer timer) {
    if (!_isActivityPaused.value) {
      if (_sessionDuration.value.inSeconds < widget.duration.inSeconds) {
        _sessionDuration.value += Duration(seconds: 1);

        // Check if it's a new minute (every 60 seconds)
        if (_sessionDuration.value.inSeconds % 60 == 0) {
          _incrementCoinsAndXP();
        }
      } else {
        _closeTimer();
      }
    }
  }

  // Increment 1 coin and 2 XP every minute
  void _incrementCoinsAndXP() {
      coins += 1; // Increment 1 coin
      xp += 2; // Increment 2 XP
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
    _selectedMusic.dispose();
    MusicServices.playSuccessMusic();
    _sessionDuration.dispose();
    _isActivityPaused.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _giveUpPopup,
      child: RootScreen(
        title: 'Focus Timer',
        onPop: _giveUpPopup,
        action: TapWidget(
          onTap: _playMusic,
          child: SvgPicture.asset(AppIcons.headphones),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 28.h),
          child: ValueListenableBuilder(
            valueListenable: _sessionDuration,
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
                        onTap: _giveUpPopup,
                        svg: AppIcons.closeCircle,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _selectedMusic,
                        builder: (context, music, _) {
                          return CustomIconButton(
                            svg: music == MusicFlavors.none ? AppIcons.play : AppIcons.pause,
                            onTap: () {
                              if (music == MusicFlavors.none) {
                                MusicServices.play(_previousMusic?.url ?? MusicFlavors.music.url);
                                _selectedMusic.value = _previousMusic ?? MusicFlavors.music;
                              } else {
                                MusicServices.stop();
                                _selectedMusic.value = MusicFlavors.none;
                              }
                            },
                          );
                        },
                      ),
                      // ValueListenableBuilder(
                      //   valueListenable: _isActivityPaused,
                      //   builder: (context, isPaused, _) {
                      //     return CustomIconButton(
                      //       // onTap: isPaused ? _playTimer : _pauseTimer,
                      //       onTap: () => _isActivityPaused.value = !_isActivityPaused.value,
                      //       svg: isPaused ? AppIcons.play : AppIcons.pause,
                      //     );
                      //   },
                      // ),
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
              child: AvatarAnimationWidget(
                    // type: widget.activity,
                    // minute: widget.duration.inMinutes,
                    activity: widget.activity,
                    minute: widget.duration.inMinutes,
                  ) ??
                  Image.asset(
                    // DummyIcons.activity,
                    'assets/dummy/${widget.activity}.webp',
                    fit: BoxFit.cover,
                  ),
            ),
            44.height,
            Divider(color: ThemeColor.hint, indent: 80.w, endIndent: 80.w),
            10.height,
            ValueListenableBuilder(
              valueListenable: _sessionDuration,
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
    Logger.logSuccess('earned xp: $xp, coins: $coins');
    context.pushReplacementNamed(ActivityResultScreen.id, extra: {
      'xp': xp,
      'coins': coins,
      'duration': widget.duration,
    });
  }

  Future<void> _giveUpPopup([didPop, result]) async {
    if (didPop == true) return;

    final response = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => GiveUpPopup(),
    );

    if (response == true && mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _playMusic() async {
    final response = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => MusicSelectionPopup(
        selectedMusic: _selectedMusic.value,
        onChanged: (value) {
          _selectedMusic.value = value;
          if (value != MusicFlavors.none) _previousMusic = value;
        },
      ),
    );

    if (response == '' && mounted) {}
  }
}
