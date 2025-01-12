import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/root_screen.dart';
import 'package:happy_habit/core/theme/typography.dart';

class ActivityResultScreen extends StatelessWidget {
  static const id = 'ActivityResultScreen';

  const ActivityResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootScreen(
      title: 'Focus Timer',
      child: Column(
        children: [
          40.height,
          SvgPicture.asset(
            AppIcons.happyStar,
            width: 150.r,
            height: 150.r,
          ),
          Text(
            'Congratulations',
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
