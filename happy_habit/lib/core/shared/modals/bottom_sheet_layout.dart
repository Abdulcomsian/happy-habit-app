import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetLayout extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;

  const BottomSheetLayout({
    super.key,
    required this.child,
    this.horizontalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding.w,
          right: horizontalPadding.w,
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust padding based on the keyboard
        ),
        child: child,
      ),
    );
  }
}
