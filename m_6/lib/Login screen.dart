// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
//import '../services/auth_service.dart';
//import '../utils/constants.dart';
import 'Auth service.dart';
import 'Constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  final AuthService _authService = AuthService();

  late AnimationController _animCtrl;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final result = await _authService.login(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Welcome back! 👋'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['error'] ?? 'Login failed'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  // Header
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Column(
                      children: [
                        const Text(
                          '🏙️',
                          style: TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'MyCityConnect',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your City, Your Services',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Card
                  SlideTransition(
                    position: _slideAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Sign in to explore services near you',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Email
                              TextFormField(
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Email Address',
                                  prefixIcon: Icon(Icons.email_outlined,
                                      color: AppColors.primary),
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!v.contains('@')) return 'Enter a valid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              // Password
                              TextFormField(
                                controller: _passCtrl,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline,
                                      color: AppColors.primary),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.textSecondary,
                                    ),
                                    onPressed: () => setState(
                                            () => _obscurePassword = !_obscurePassword),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (v.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Forgot password feature coming soon!')),
                                    );
                                  },
                                  child: const Text('Forgot Password?',
                                      style: TextStyle(color: AppColors.primary)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _login,
                                  child: _isLoading
                                      ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                      : const Text('Sign In'),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Divider
                              Row(
                                children: [
                                  const Expanded(child: Divider()),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      'or',
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  ),
                                  const Expanded(child: Divider()),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Register Button
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, AppRoutes.register),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    side: const BorderSide(color: AppColors.primary),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text(
                                    'Create New Account',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Demo hint
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.primary, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Demo: Use any email (with @) and 6+ char password',
                            style: TextStyle(fontSize: 12, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}