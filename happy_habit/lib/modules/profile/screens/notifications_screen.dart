import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/root_screen.dart';
import '../../../core/theme/theme_colors.dart';

class NotificationsScreen extends StatefulWidget {
  static const id = 'NotificationsScreen';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _allowNotifications = ValueNotifier(false);

  @override
  void dispose() {
    _allowNotifications.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Notifications',
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                'Notifications',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Allow app notification'),
              ValueListenableBuilder(
                valueListenable: _allowNotifications,
                builder: (context, vl, _) {
                  return Transform.scale(
                    scaleY: 0.8,
                    scaleX: 0.9,
                    child: Switch(
                      value: vl,
                      onChanged: (value) => _allowNotifications.value = value,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
