// lib/presentation/screens/splash_screen.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/preferences/pref_service.dart';
import '../widgets/common_widgets.dart';
import 'auth/login_screen.dart';
import 'dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    final isLoggedIn = await PrefService().isLoggedIn();
    final userName = await PrefService().getUserName();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isLoggedIn && userName != null
              ? DashboardScreen(userName: userName)
              : const LoginScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.backgroundPurple, AppTheme.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: const EcorpLogo(size: 90),
                ),
              ),
              const SizedBox(height: 16),
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Interview Preparation',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const CircularProgressIndicator(
                color: Colors.white54,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
