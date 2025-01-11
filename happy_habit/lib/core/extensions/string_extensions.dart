/// Capitalizing each word of a sentence or just the first word.
extension Capitalize on String {
  /// Capitalizes the string based on the [capitalizeAllWords] flag.
  /// If [capitalizeAllWords] is `true`, capitalizes the first letter of each word.
  /// If `false`, capitalizes only the first letter of the sentence.
  String capitalize({bool capitalizeAllWords = true}) {
    if (isEmpty) return '';

    // Trim leading and trailing spaces.
    String value = trim();

    // Replace multiple spaces with a single space.
    String cleanedString = value.replaceAll(RegExp(r'\s+'), ' ');

    if (capitalizeAllWords) {
      // Split the string into words.
      List<String> words = cleanedString.split(' ');

      // Capitalize the initial letter of each word.
      return words.map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
    } else {
      // Capitalize only the first letter of the sentence.
      return cleanedString[0].toUpperCase() + cleanedString.substring(1).toLowerCase();
    }
  }
}