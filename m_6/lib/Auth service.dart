// lib/services/auth_service.dart
//
// NOTE: This service is structured for Firebase Auth + Realtime Database.
// To activate Firebase:
//   1. Run: flutterfire configure  (installs firebase_options.dart)
//   2. Uncomment Firebase imports and calls below.
//   3. Remove the mock simulation blocks.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Uncomment after flutterfire configure:
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

class AuthService {
  // --- Firebase instances (uncomment after setup) ---
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final DatabaseReference _db = FirebaseDatabase.instance.ref();

  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserName = 'userName';
  static const _keyUserId = 'userId';

  // ─────────────────────────────────────────────────────────────────
  //  REGISTER
  // ─────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // ── FIREBASE (uncomment) ──────────────────────────────────────
      // UserCredential cred = await _auth.createUserWithEmailAndPassword(
      //   email: email, password: password,
      // );
      // await cred.user!.updateDisplayName(name);
      // await _db.child('users/${cred.user!.uid}').set({
      //   'name': name, 'email': email,
      //   'createdAt': ServerValue.timestamp,
      // });
      // await _saveSession(cred.user!.uid, name, email);
      // return {'success': true, 'userId': cred.user!.uid};

      // ── MOCK SIMULATION ───────────────────────────────────────────
      await Future.delayed(const Duration(seconds: 1));
      const mockUid = 'mock_user_001';
      await _saveSession(mockUid, name, email);
      return {'success': true, 'userId': mockUid};
      // ─────────────────────────────────────────────────────────────
    } catch (e) {
      return {'success': false, 'error': _friendlyError(e.toString())};
    }
  }

  // ─────────────────────────────────────────────────────────────────
  //  LOGIN
  // ─────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // ── FIREBASE (uncomment) ──────────────────────────────────────
      // UserCredential cred = await _auth.signInWithEmailAndPassword(
      //   email: email, password: password,
      // );
      // final snap = await _db.child('users/${cred.user!.uid}').get();
      // final name = snap.child('name').value?.toString() ?? email.split('@')[0];
      // await _saveSession(cred.user!.uid, name, email);
      // return {'success': true, 'userId': cred.user!.uid};

      // ── MOCK SIMULATION ───────────────────────────────────────────
      await Future.delayed(const Duration(seconds: 1));
      if (email.isEmpty || !email.contains('@')) {
        return {'success': false, 'error': 'Invalid email address.'};
      }
      if (password.length < 6) {
        return {'success': false, 'error': 'Password must be at least 6 characters.'};
      }
      const mockUid = 'mock_user_001';
      final name = email.split('@')[0];
      await _saveSession(mockUid, name, email);
      return {'success': true, 'userId': mockUid};
      // ─────────────────────────────────────────────────────────────
    } catch (e) {
      return {'success': false, 'error': _friendlyError(e.toString())};
    }
  }

  // ─────────────────────────────────────────────────────────────────
  //  LOGOUT
  // ─────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    // await _auth.signOut();   // Firebase
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ─────────────────────────────────────────────────────────────────
  //  SESSION HELPERS
  // ─────────────────────────────────────────────────────────────────
  Future<void> _saveSession(String uid, String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserId, uid);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<Map<String, String>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'uid': prefs.getString(_keyUserId) ?? '',
      'name': prefs.getString(_keyUserName) ?? 'User',
      'email': prefs.getString(_keyUserEmail) ?? '',
    };
  }

  // ─────────────────────────────────────────────────────────────────
  //  SAVE BOOKING TO FIREBASE REALTIME DATABASE
  // ─────────────────────────────────────────────────────────────────
  Future<bool> saveBooking(String userId, Map<String, dynamic> booking) async {
    try {
      // ── FIREBASE (uncomment) ──────────────────────────────────────
      // final ref = _db.child('bookings/$userId').push();
      // await ref.set({...booking, 'createdAt': ServerValue.timestamp});

      // ── MOCK ─────────────────────────────────────────────────────
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint('Booking saved (mock): $booking');
      return true;
    } catch (e) {
      debugPrint('Save booking error: $e');
      return false;
    }
  }

  // ─────────────────────────────────────────────────────────────────
  //  ERROR MESSAGES
  // ─────────────────────────────────────────────────────────────────
  String _friendlyError(String raw) {
    if (raw.contains('email-already-in-use')) return 'Email is already registered.';
    if (raw.contains('user-not-found')) return 'No account found with this email.';
    if (raw.contains('wrong-password')) return 'Incorrect password.';
    if (raw.contains('weak-password')) return 'Password is too weak.';
    if (raw.contains('network-request-failed')) return 'No internet connection.';
    return 'Something went wrong. Please try again.';
  }
}