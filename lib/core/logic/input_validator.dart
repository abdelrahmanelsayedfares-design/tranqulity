class InputValidator {
  static String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return 'phone Must be Not Empty';
    } else if (value.length < 10) {
      return 'phone Must be 10 Digits';
    }
    return null;
  }
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email must not be empty';
    } else if (!RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }
  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'password Must be Not Empty';
    } else if (value.length < 6) {
      return 'password Must be 6 Digits';
    }
    return null;
  }
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }
  static String? ageValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age cannot be empty';
    }

    final age = int.tryParse(value);

    if (age == null) {
      return 'Age must be a number';
    }

    if (age < 1 || age > 120) {
      return 'Enter a valid age';
    }

    return null;
  }
  static String? genderValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select gender';
    }
    return null;
  }
  static String? verifyValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP is required';
    }

    if (value.trim().length != 4) {
      return 'OTP must be 4 digits';
    }

    return null;
  }
  static String? chatValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Chat cannot be empty';
    }

    if (value.trim().length < 3) {
      return 'Chat must be at least 3 characters';
    }

    return null;
  }

}
