// lib/services/preferences_service.dart
// Handles all shared_preferences reads and writes for TaskMate

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  // ── Key constants ──────────────────────────────────────
  static const String _keyThemeMode      = 'theme_mode';
  static const String _keyUsername       = 'username';
  static const String _keyLastScreen     = 'last_screen';
  static const String _keyOnboardingDone = 'onboarding_done';
  static const String _keyDefaultFilter  = 'default_filter';

  // ─────────────────────────────────────────────
  // THEME MODE
  // ─────────────────────────────────────────────

  /// Save the user's chosen theme mode
  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, mode.name); // 'system' | 'light' | 'dark'
  }

  /// Retrieve the saved theme mode (defaults to system)
  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyThemeMode) ?? 'system';
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // ─────────────────────────────────────────────
  // USERNAME / DISPLAY NAME
  // ─────────────────────────────────────────────

  Future<void> saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, name.trim());
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? 'Freelancer';
  }

  // ─────────────────────────────────────────────
  // LAST VISITED SCREEN
  // ─────────────────────────────────────────────

  Future<void> saveLastScreen(String screenName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastScreen, screenName);
  }

  Future<String> getLastScreen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastScreen) ?? 'home';
  }

  // ─────────────────────────────────────────────
  // ONBOARDING
  // ─────────────────────────────────────────────

  Future<void> setOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingDone, true);
  }

  Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingDone) ?? false;
  }

  // ─────────────────────────────────────────────
  // DEFAULT TASK FILTER
  // ─────────────────────────────────────────────

  Future<void> saveDefaultFilter(String filter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDefaultFilter, filter);
  }

  Future<String> getDefaultFilter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDefaultFilter) ?? 'all';
  }

  // ─────────────────────────────────────────────
  // CLEAR ALL (reset / logout)
  // ─────────────────────────────────────────────

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}