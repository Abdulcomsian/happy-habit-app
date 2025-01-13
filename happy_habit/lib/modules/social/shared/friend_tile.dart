import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';
import 'package:happy_habit/modules/profile/screens/profile_screen.dart';

import '../../chat/chat_screen.dart';

class FriendTile extends StatelessWidget {
  final bool isFriend;
  final int? xpPoints;
  final VoidCallback? onViewProfile;

  const FriendTile({
    super.key,
    this.xpPoints,
    this.onViewProfile,
    this.isFriend = true,
  });

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: () => context.pushNamed(ProfileScreen.id),
      // onTap: () => context.goNamed(ProfileScreen.id),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Card(
                color: ThemeColor.primary,
                child: Image.asset(
                  DummyIcons.man,
                  width: 57.r,
                  height: 57.r,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              13.width,
              Expanded(
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    7.height,
                    Text(
                      xpPoints != null ? 'XP $xpPoints' : 'View Profile',
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: xpPoints == null ? ThemeColor.primary : null,
                      ),
                    ),
                  ],
                ),
              ),
              if (isFriend)
                TapWidget(
                  radius: 4,
                  color: ThemeColor.primary,
                  onTap: () => _chat(context),
                  padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
                  child: Text(
                    'Chat',
                    style: context.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else ...[
                TapWidget(
                  radius: 4,
                  onTap: _decline,
                  color: ThemeColor.error.withValues(alpha: 0.4),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Text(
                    'Decline',
                    style: context.bodySmall?.copyWith(
                      color: ThemeColor.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.width,
                TapWidget(
                  radius: 4,
                  onTap: _accept,
                  color: ThemeColor.primary,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  child: Text(
                    'Accept',
                    style: context.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _chat(BuildContext context) async {
    context.pushNamed(ChatScreen.id);
  }

  Future<void> _accept() async {}

  Future<void> _decline() async {}
}
