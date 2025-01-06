import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/shared/widgets/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback? onAction;
  final String svg, title, message, actionLabel;

  const CustomDialog({
    super.key,
    this.onAction,
    required this.svg,
    required this.title,
    required this.message,
    this.actionLabel = 'Done',
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: SvgPicture.asset(
            svg,
            width: 171.w,
            height: 151.h,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: DialogTheme.of(context).titleTextStyle,
            ),
            10.height,
            Text(
              message,
              textAlign: TextAlign.center,
              style: DialogTheme.of(context).contentTextStyle,
            ),
            32.height,
            if (onAction != null)
              CustomButton(
                label: actionLabel,
                onPressed: onAction,
              ),
          ],
        ),
      ),
    );
  }
}
