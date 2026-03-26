// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Brand Colors
  static const Color primaryPurple = Color(0xFF6B2FD9);
  static const Color deepPurple = Color(0xFF4A1FA8);
  static const Color lightPurple = Color(0xFF9B59E8);
  static const Color accentOrange = Color(0xFFFF8C00);
  static const Color accentAmber = Color(0xFFFFA726);
  static const Color backgroundPurple = Color(0xFF7B35E8);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color successGreen = Color(0xFF10B981);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color quizGreen = Color(0xFF4CAF50);
  static const Color quizRed = Color(0xFFF44336);
  static const Color inputBg = Color(0xFFF3F0FF);
  static const Color dividerColor = Color(0xFFE5E7EB);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        primary: primaryPurple,
        secondary: accentOrange,
        surface: cardWhite,
        error: errorRed,
      ),
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: TextStyle(color: textGrey.withOpacity(0.7), fontSize: 14),
        errorStyle: const TextStyle(color: errorRed, fontSize: 12),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shadowColor: primaryPurple.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: cardWhite,
      ),
      // cardTheme: CardTheme(
      //   elevation: 4,
      //   shadowColor: primaryPurple.withOpacity(0.15),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      //   color: cardWhite,
      // ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
