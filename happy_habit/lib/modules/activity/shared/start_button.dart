import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/shared/widgets/tap_widget.dart';
import 'package:happy_habit/core/theme/typography.dart';

class StartButton extends StatelessWidget {
  final VoidCallback onTap;

  const StartButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapWidget(
      onTap: onTap,
      radius: 10000,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(9.r),
          padding: EdgeInsets.all(45.r),
          decoration: BoxDecoration(
            border: Border.all(),
            shape: BoxShape.circle,
            color: Color(0xffAFE8FB),
          ),
          child: Text(
            'Start',
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
