import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import '../services/auth_service.dart';
import 'Q1 Auth service.dart';
import 'Q1 Home screen.dart';
import 'Q1 Login screen.dart';
//import 'login_screen.dart';
//import 'home_screen.dart';

/// Listens to Firebase auth state and routes accordingly.
/// - If user is authenticated  → HomeScreen
/// - If user is not logged in  → LoginScreen
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {

        // ── While Firebase checks the persisted session ──────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0A0A0F),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6C63FF),
                strokeWidth: 2.5,
              ),
            ),
          );
        }

        // ── Error state ──────────────────────────────────────────────────
        if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor: Color(0xFF0A0A0F),
            body: Center(
              child: Text(
                'Something went wrong.\nPlease restart the app.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
          );
        }

        // ── Authenticated → Home ──────────────────────────────────────────
        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }

        // ── Unauthenticated → Login ───────────────────────────────────────
        return const LoginScreen();
      },
    );
  }
}