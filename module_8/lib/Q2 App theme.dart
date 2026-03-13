import 'package:flutter/material.dart';

import 'Q2 Task model.dart';
//import 'task_model.dart';

// ─────────────────────────────────────────────
//  COLORS
// ─────────────────────────────────────────────
class AppColors {
  // Backgrounds
  static const bg       = Color(0xFF0A0A12);
  static const surface  = Color(0xFF111120);
  static const card     = Color(0xFF16162A);
  static const cardBorder = Color(0xFF252540);

  // Accent
  static const primary   = Color(0xFF7C6FF7);
  static const primarySoft= Color(0x267C6FF7);

  // Status
  static const success  = Color(0xFF3DD68C);
  static const warning  = Color(0xFFFFB547);
  static const danger   = Color(0xFFFF6B6B);
  static const info     = Color(0xFF56AEFF);

  // Priority colors
  static const lowPriority    = Color(0xFF3DD68C);
  static const mediumPriority = Color(0xFFFFB547);
  static const highPriority   = Color(0xFFFF6B6B);

  // Category colors
  static const personal  = Color(0xFF9B87F5);
  static const work      = Color(0xFF56AEFF);
  static const shopping  = Color(0xFFFF9F43);
  static const health    = Color(0xFF3DD68C);
  static const other     = Color(0xFFAAAAAA);
}

// ─────────────────────────────────────────────
//  THEME
// ─────────────────────────────────────────────
class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.danger,
    ),
    cardColor: AppColors.card,
    dividerColor: AppColors.cardBorder,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      labelStyle: const TextStyle(color: Colors.white54),
      hintStyle: const TextStyle(color: Colors.white24),
    ),
    textTheme: const TextTheme(
      titleLarge:  TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.5),
      titleMedium: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium:  TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
      bodySmall:   TextStyle(color: Colors.white38, fontSize: 12),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      iconTheme: IconThemeData(color: Colors.white70),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 6,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primarySoft,
      labelStyle: const TextStyle(fontSize: 12, color: Colors.white70),
      side: const BorderSide(color: AppColors.cardBorder),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}

// ─────────────────────────────────────────────
//  PRIORITY HELPERS
// ─────────────────────────────────────────────
extension PriorityX on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low:    return 'Low';
      case TaskPriority.medium: return 'Medium';
      case TaskPriority.high:   return 'High';
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.low:    return AppColors.lowPriority;
      case TaskPriority.medium: return AppColors.mediumPriority;
      case TaskPriority.high:   return AppColors.highPriority;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskPriority.low:    return Icons.arrow_downward_rounded;
      case TaskPriority.medium: return Icons.remove_rounded;
      case TaskPriority.high:   return Icons.arrow_upward_rounded;
    }
  }
}

// ─────────────────────────────────────────────
//  CATEGORY HELPERS
// ─────────────────────────────────────────────
extension CategoryX on TaskCategory {
  String get label {
    switch (this) {
      case TaskCategory.personal: return 'Personal';
      case TaskCategory.work:     return 'Work';
      case TaskCategory.shopping: return 'Shopping';
      case TaskCategory.health:   return 'Health';
      case TaskCategory.other:    return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.personal: return AppColors.personal;
      case TaskCategory.work:     return AppColors.work;
      case TaskCategory.shopping: return AppColors.shopping;
      case TaskCategory.health:   return AppColors.health;
      case TaskCategory.other:    return AppColors.other;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.personal: return Icons.person_outline_rounded;
      case TaskCategory.work:     return Icons.work_outline_rounded;
      case TaskCategory.shopping: return Icons.shopping_cart_outlined;
      case TaskCategory.health:   return Icons.favorite_border_rounded;
      case TaskCategory.other:    return Icons.category_outlined;
    }
  }
}