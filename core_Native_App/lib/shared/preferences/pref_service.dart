// lib/shared/preferences/pref_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

/// Service class for managing SharedPreferences.
/// Handles user session persistence.
class PrefService {
  static final PrefService _instance = PrefService._internal();
  PrefService._internal();
  factory PrefService() => _instance;

  /// Saves user session after successful login.
  Future<void> saveUserSession({
    required int userId,
    required String userName,
    required String userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefIsLoggedIn, true);
    await prefs.setInt(AppConstants.prefUserId, userId);
    await prefs.setString(AppConstants.prefUserName, userName);
    await prefs.setString(AppConstants.prefUserEmail, userEmail);
  }

  /// Clears user session on logout.
  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.prefIsLoggedIn);
    await prefs.remove(AppConstants.prefUserId);
    await prefs.remove(AppConstants.prefUserName);
    await prefs.remove(AppConstants.prefUserEmail);
  }

  /// Checks if user is logged in.
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.prefIsLoggedIn) ?? false;
  }

  /// Gets the logged-in user's name.
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.prefUserName);
  }

  /// Gets the logged-in user's email.
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.prefUserEmail);
  }

  /// Gets the logged-in user's ID.
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppConstants.prefUserId);
  }
}
