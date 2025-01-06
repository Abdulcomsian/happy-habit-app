import 'dart:ui' as ui;

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
  RichText richText(String text, {TextStyle? style, bool withTag = false}) => RichText(
        text: _formatText(this, text, style: style, withTag: withTag),
      );

  TextSpan _formatText(BuildContext context, String text,
      {TextStyle? style, bool withTag = false}) {
    List<InlineSpan> spans = [];
    String pattern = r'\*(.*?)\*';
    RegExp regExp = RegExp(pattern);

    int start = 0;

    // Find all matches and create spans
    for (RegExpMatch match in regExp.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }

      InlineSpan wrappedTextSpan;
      if (withTag) {
        wrappedTextSpan = WidgetSpan(
          alignment: ui.PlaceholderAlignment.middle,
          child: Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: ThemeColor.primary.withValues(alpha: 0.4),
            ),
            child: Text(
              match.group(1)!,
              style: (style ?? context.bodyMedium)?.copyWith(
                color: ThemeColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        wrappedTextSpan = TextSpan(
          text: match.group(1), // The text between the asterisks
          style: (style ?? context.bodyMedium)?.copyWith(
            color: ThemeColor.primary,
            fontWeight: FontWeight.bold,
          ),
        );
      }

      spans.add(wrappedTextSpan);
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
