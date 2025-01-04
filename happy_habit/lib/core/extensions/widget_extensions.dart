import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

/// returning SizedBox with coming dimension
extension IntToSizedBox on int {
  Widget get height => SizedBox(height: toDouble().h);

  Widget get width => SizedBox(width: toDouble().w);
}

extension FormatedRichText on BuildContext {
  RichText richText(String text, {TextStyle? style}) => RichText(
        text: _formatText(this, text, style: style),
      );

  TextSpan _formatText(BuildContext context, String text, {TextStyle? style}) {
    List<TextSpan> spans = [];
    String pattern = r'\*(.*?)\*';
    RegExp regExp = RegExp(pattern);

    int start = 0;

    // Find all matches and create spans
    for (RegExpMatch match in regExp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1), // The text between the asterisks
        style: (style ?? context.bodyMedium)?.copyWith(
          color: ThemeColor.primary,
          fontWeight: FontWeight.bold,
        ),
      ));
      start = match.end;
    }

    // Add the remaining text after the last match
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return TextSpan(
      children: spans,
      style: style ?? context.bodyMedium,
    );
  }
}
