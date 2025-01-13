import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/chat/services/chat_message.dart';
import 'package:happy_habit/modules/profile/shared/profile_header.dart';

import '../../../core/theme/theme_colors.dart';

enum MessageStatus { sent, delivered, read }

class ChatBubble extends StatelessWidget {
  final bool isCurrentUser; // Determines if it's the current user's message
  final ChatMessage message;
  final MessageStatus status; // Message delivery status

  const ChatBubble({
    super.key,
    required this.status,
    required this.message,
    this.isCurrentUser = true,
  });

  @override
  Widget build(BuildContext context) {
    // Define the background color based on the sender
    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          );

    // Format the time
    String time =
        '${message.createdAt.hour}:${message.createdAt.minute < 10 ? '0${message.createdAt.minute}' : message.createdAt.minute} ${message.createdAt.hour < 12 ? 'AM' : 'PM'}';

    // Define the tick status icon
    Widget statusIcon;
    switch (status) {
      case MessageStatus.sent:
        statusIcon = SvgPicture.asset(AppIcons.doubleCheck);
        break;
      case MessageStatus.delivered:
        statusIcon = SvgPicture.asset(AppIcons.doubleCheck);
        break;
      case MessageStatus.read:
        statusIcon = SvgPicture.asset(AppIcons.doubleCheck);
        break;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            ProfileAvatar(
              size: 32.r,
              removeBorder: true,
            ),
            20.width,
          ] else
            Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: ThemeColor.primary,
                  borderRadius: borderRadius,
                ),
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Text(
                  message.text,
                  style: context.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              10.height,
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.doubleCheck,
                  ),
                  5.width,
                  Text(
                    time,
                    style: context.labelMedium,
                  ),
                ],
              ),
            ],
          ),
          if (isCurrentUser) ...[
            20.width,
            ProfileAvatar(
              size: 32.r,
              removeBorder: true,
            ),
          ] else
            Spacer(),
        ],
      ),
    );
  }
}
