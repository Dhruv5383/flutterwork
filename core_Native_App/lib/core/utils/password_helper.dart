// lib/core/utils/password_helper.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Handles password hashing for secure storage.
class PasswordHelper {
  PasswordHelper._();

  /// Hashes a password using SHA-256.
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verifies a plain-text password against a stored hash.
  static bool verifyPassword(String plainPassword, String hashedPassword) {
    return hashPassword(plainPassword) == hashedPassword;
  }
}
