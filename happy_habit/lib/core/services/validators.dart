class Validators {
  static String? pinValidationCheck(String? value) {
    final trimText = value!.trim();
    if (trimText.isEmpty) {
      return 'Please enter pin code';
    } else if (trimText.length < 4) {
      return 'Please enter 4 digits pin';
    } else {
      return null;
    }
  }

}