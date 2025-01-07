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

  static String? emailValidation(String? value) {
     final RegExp emailRegex = RegExp(r'^[\w.-]+@[a-zA-Z_-]+?(?:\.[a-zA-Z]{2,})+$');

    final trimEmail = value!.trim();
    if (trimEmail.isNotEmpty) {
      if (!emailRegex.hasMatch(value)) {
        return 'Please provide a valid email';
      } else {
        return null;
      }
    } else {
      return 'Enter a valid email';
    }
  }

  static String? passwordValidation(
      String? value, {
        String? value2,
        String? comMsg,
        String? emptyMsg,
        bool applyLimit = true,
      }) {
    final trimText = value!.trim();
    if (trimText.isEmpty) {
      return emptyMsg ?? 'Enter a password';
    } else if (trimText.length < 6 && applyLimit) {
      return 'Password should be at least 6 characters';
    } else if (value2 != null && value2 != trimText) {
      return comMsg ?? 'Password must match';
    } else {
      return null;
    }
  }

  static String? emptyValidationCheck(String? value, {String? message}) {
    final trimText = value!.trim();
    if (trimText.isEmpty) {
      return message ?? '* required';
    } else {
      return null;
    }
  }
}