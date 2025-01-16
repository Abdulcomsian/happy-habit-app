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
}
