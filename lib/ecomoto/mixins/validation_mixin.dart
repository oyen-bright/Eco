mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address.';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  String? validatePasswordConfirm(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateYear(String? input) {
    if (input == null || input.isEmpty) {
      return 'required';
    }
    RegExp regex = RegExp(r'^\d{4}$');
    if (regex.hasMatch(input)) {
      return null;
    }
    return "Invalid date";
  }

  String? validateMMYYYY(String? input) {
    if (input == null || input.isEmpty) {
      return 'required';
    }

    RegExp regex = RegExp(r'^\d{2}/\d{4}$');
    if (!regex.hasMatch(input)) {
      return 'Invalid format, please use "mm/yyyy"';
    }

    List<String> parts = input.split('/');
    int month = int.tryParse(parts[0]) ?? 0;
    int year = int.tryParse(parts[1]) ?? 0;

    if (month < 1 || month > 12) {
      return 'Invalid month';
    }

    if (year < 1900 || year > 2100) {
      return 'Invalid year';
    }

    return null;
  }

  String? validateEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName.';
    }
    return null;
  }

  String? validatePhoneNumber(String? input) {
    if (input == null || input.isEmpty) {
      return 'required';
    }

    RegExp phoneNumberRegExp = RegExp(
      r'^\d{10}$',
      caseSensitive: false,
      multiLine: false,
    );

    if (!phoneNumberRegExp.hasMatch(input.replaceAll(RegExp(r'[-()\s]'), ''))) {
      return 'Invalid phone number';
    }

    return null;
  }
}
