import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/constants/asset_paths.dart';
import '../../../core/shared/widgets/custom_upgrade_widget.dart';

class StoreScreen extends StatelessWidget {
  static const id = 'StoreScreen';

  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Store',
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          20.height,
          CustomUpgradeWidget(
            svg: AppIcons.crown,
            title: 'Pricing Plan',
            buttonText: 'Upgrade Plan',
            description: 'Lorem ipsum dolor sit amet,',
          ),
          15.height,
          Text(
            'Accessories',
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
