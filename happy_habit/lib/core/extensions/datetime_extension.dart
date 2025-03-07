import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedTimeStringForToday() {
    // Check if the DateTime is today
    if (isToday()) {
      return 'Today, ${DateFormat('hh:mm a').format(this)}'; // Format time as 09:00 AM
    }
    // If it's not today, return a default format or a different format
    return DateFormat('yyyy-MM-dd – hh:mm a').format(this); // Default formatting (can be customized)
  }

  bool isToday() {
    final today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }
}
