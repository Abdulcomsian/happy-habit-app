import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/shared/widgets/tap_widget.dart';
import '../../../core/theme/theme_colors.dart';
import '../../profile/shared/profile_header.dart';
import 'chat_popup_menu_button.dart';

class ChatHeader extends StatelessWidget implements PreferredSize {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Center(
        child: TapWidget(
          radius: 100,
          color: ThemeColor.primary.withValues(alpha: 0.2),
          padding: EdgeInsets.all(5.r),
          child: Icon(
            size: 18.r,
            Icons.arrow_back,
            color: ThemeColor.primary,
          ),
        ),
      ),
      title: Row(
        children: [
          ProfileAvatar(
            size: 36,
            isOnline: true,
            removeBorder: true,
          ),
          10.width,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alex Anderson',
                style: context.bodySmall?.copyWith(
                  color: ThemeColor.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Online',
                style: context.bodySmall?.copyWith(
                  color: ThemeColor.hint,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        ChatPopupMenuButton(),
        20.width,
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
