import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/typography.dart';

import '../../../core/theme/theme_colors.dart';

class ChatField extends StatelessWidget {
  final TextEditingController controller;

  const ChatField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: context.bodySmall,
        // onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          filled: true,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          fillColor: Colors.white,
          hintText: 'Type a message.',
          hintStyle: context.bodySmall?.copyWith(
            color: ThemeColor.hint,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
        ),
      ),
    );
  }

  InputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(200.r),
        borderSide: BorderSide(
          color: ThemeColor.border,
        ),
      );
}
