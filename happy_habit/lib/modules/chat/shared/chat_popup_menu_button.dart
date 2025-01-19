import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/constants/asset_paths.dart';
import 'package:happy_habit/core/shared/widgets/svg_Icon.dart';
import 'package:happy_habit/core/theme/typography.dart';

class ChatPopupMenuButton extends StatelessWidget {
  const ChatPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      onSelected: (value) {
        // Handle item selection
        if (value == 'report') {
          // Perform the report action
        } else if (value == 'block') {
          // Perform the block action
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'report',
            child: Text(
              'Report',
              // style: context.bodySmall?.copyWith(
              //   height: 1,
              // ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'block',
            child: Text(
              'Block',
              // style: context.bodySmall?.copyWith(
              //   height: 1,
              // ),
            ),
          ),
        ];
      },
      icon: SvgIcon(
        AppIcons.more,
      ),
    );
  }
}
