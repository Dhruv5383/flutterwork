// lib/presentation/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/password_helper.dart';
import '../../../data/database/database_helper.dart';
import '../../../shared/preferences/pref_service.dart';
import '../../widgets/common_widgets.dart';
import '../dashboard/dashboard_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _dbHelper = DatabaseHelper();
  final _prefService = PrefService();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final passwordHash =
          PasswordHelper.hashPassword(_passwordController.text.trim());
      final user = await _dbHelper.getUserByCredentials(
        _emailController.text.trim().toLowerCase(),
        passwordHash,
      );

      if (user == null) {
        if (mounted) {
          showSnackBar(context, 'Invalid email or password. Please try again.',
              isError: true);
        }
      } else {
        await _prefService.saveUserSession(
          userId: user.id!,
          userName: user.fullName,
          userEmail: user.email,
        );
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DashboardScreen(userName: user.fullName),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'An error occurred. Please try again.',
            isError: true);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const EcorpLogo(size: 80),
                      const SizedBox(height: 8),
                      Text(
                        'Interview Preparation',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 14,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Card
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.deepPurple.withOpacity(0.25),
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
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sign in to continue your prep journey',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textGrey,
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                prefixIcon: Icons.person_outline,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.validateLoginEmail,
                                focusNode: _emailFocus,
                                nextFocusNode: _passwordFocus,
                              ),
                              const SizedBox(height: 14),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                validator: Validators.validateLoginPassword,
                                focusNode: _passwordFocus,
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    showSnackBar(context,
                                        'Please contact support to reset your password.');
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: AppTheme.primaryPurple,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              PrimaryButton(
                                text: 'LOGIN',
                                onPressed: _login,
                                isLoading: _isLoading,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const SignupScreen()),
                                    );
                                  },
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'New user? ',
                                      style: TextStyle(
                                        color: AppTheme.textGrey,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'SIGNUP',
                                          style: TextStyle(
                                            color: AppTheme.primaryPurple,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
