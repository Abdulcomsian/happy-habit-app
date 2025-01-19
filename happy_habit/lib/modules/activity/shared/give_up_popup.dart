import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class GiveUpPopup extends StatelessWidget {
  const GiveUpPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(
          'Are you sure to give up?',
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        content: Text(
          'There will be 1 withered tree(s) in your forest',
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(
            color: ThemeColor.graphiteGrey,
          ),
        ),
        actions: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: CustomButton(
                  label: 'No',
                  color: Colors.grey.shade300,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              10.width,
              Flexible(
                child: CustomButton(
                  label: 'Give up',
                  color: Colors.redAccent.shade200,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
