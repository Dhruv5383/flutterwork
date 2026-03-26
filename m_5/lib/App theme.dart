// lib/theme/app_theme.dart
// Material 3 theme definitions for TaskMate (light & dark)

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ── Brand color seeds ──────────────────────────────────
  static const Color _seedColor      = Color(0xFF4F6AF5); // Indigo-blue
  static const Color _accentOrange   = Color(0xFFFF7043);
  static const Color _accentGreen    = Color(0xFF26C36F);
  static const Color _pendingChip    = Color(0xFFFFB300);
  static const Color _progressChip   = Color(0xFF4F6AF5);
  static const Color _completedChip  = Color(0xFF26C36F);

  static Color statusColor(String status) {
    switch (status) {
      case 'in_progress': return _progressChip;
      case 'completed':   return _completedChip;
      default:            return _pendingChip;
    }
  }

  // ── LIGHT THEME ────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F6FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F6FA),
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1D2E),
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: Color(0xFF1A1D2E)),
    ),cardTheme: const CardThemeData(
    elevation: 0,
    color: const Color(0xFF1C1F2E),
    shape: const RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  ),
    // cardTheme: CardTheme(
    //   elevation: 0,
    //   color: Colors.white,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(16)),
    //   ),
    //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    // ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _seedColor,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF0F2FF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _seedColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    extensions: const [_TaskMateColors.light],
  );

  // ── DARK THEME ─────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F1117),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F1117),
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFFEAEBF5),
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: Color(0xFFEAEBF5)),
    ),cardTheme: const CardThemeData(
    elevation: 0,
    color: Color(0xFF1C1F2E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  ),
    // cardTheme: CardTheme(
    //   elevation: 0,
    //   color: const Color(0xFF1C1F2E),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(16)),
    //   ),
    //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    // ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _seedColor,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF252840),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _seedColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    extensions: const [_TaskMateColors.dark],
  );
}

// ── Custom theme extension for app-specific colors ──────
@immutable
class _TaskMateColors extends ThemeExtension<_TaskMateColors> {
  final Color overdueColor;
  final Color cardBorder;
  final Color subtleText;

  const _TaskMateColors({
    required this.overdueColor,
    required this.cardBorder,
    required this.subtleText,
  });

  static const light = _TaskMateColors(
    overdueColor: Color(0xFFE53935),
    cardBorder:   Color(0xFFE8EAF6),
    subtleText:   Color(0xFF9E9EBB),
  );

  static const dark = _TaskMateColors(
    overdueColor: Color(0xFFEF5350),
    cardBorder:   Color(0xFF2A2D40),
    subtleText:   Color(0xFF6B6E85),
  );

  @override
  _TaskMateColors copyWith({Color? overdueColor, Color? cardBorder, Color? subtleText}) =>
      _TaskMateColors(
        overdueColor: overdueColor ?? this.overdueColor,
        cardBorder:   cardBorder   ?? this.cardBorder,
        subtleText:   subtleText   ?? this.subtleText,
      );

  @override
  _TaskMateColors lerp(_TaskMateColors? other, double t) {
    if (other == null) return this;
    return _TaskMateColors(
      overdueColor: Color.lerp(overdueColor, other.overdueColor, t)!,
      cardBorder:   Color.lerp(cardBorder,   other.cardBorder,   t)!,
      subtleText:   Color.lerp(subtleText,   other.subtleText,   t)!,
    );
  }
}