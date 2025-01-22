import 'package:flutter/cupertino.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/typography.dart';

extension DurationFormatting on Duration {
  String toFormattedString({String symbol = 'h', bool includeSeconds = false}) {
    int hours = inHours;
    int minutes = inMinutes % 60;
    int seconds = inSeconds % 60;

    // Formatting hours, minutes, and seconds to always show two digits
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    // If seconds should be included, format as hh:mm:ss
    if (includeSeconds) {
      return '$formattedHours:$formattedMinutes:$formattedSeconds';
    } else {
      // Otherwise, format as hh:mm h
      return '$formattedHours:$formattedMinutes $symbol';
    }
  }

  Widget toWidget(BuildContext context) {
    String hours = inHours.toString().padLeft(2, '0');
    String minutes = (inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (inSeconds % 60).toString().padLeft(2, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              hours,
              style: context.titleLarge,
            ),
            7.5.height,
            Text(
              'Hours',
              style: context.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        24.width,
        Column(
          children: [
            Text(
              minutes,
              style: context.titleLarge,
            ),
            7.5.height,
            Text(
              'Minutes',
              style: context.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        24.width,
        Column(
          children: [
            Text(
              seconds,
              style: context.titleLarge,
            ),
            7.5.height,
            Text(
              'Seconds',
              style: context.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
