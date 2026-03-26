// lib/core/utils/validators.dart

import '../constants/app_constants.dart';

/// Utility class for form field validations.
/// Encapsulates all validation logic in one place (Encapsulation principle).
class Validators {
  Validators._();

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    }
    if (!AppConstants.nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid first name (letters only, 2-50 chars)';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required';
    }
    if (!AppConstants.nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid last name (letters only, 2-50 chars)';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!AppConstants.emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    if (!AppConstants.passwordRegex.hasMatch(value)) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateLoginEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!AppConstants.emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}
