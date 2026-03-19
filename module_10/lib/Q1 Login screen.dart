import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import '../services/auth_service.dart';
//import '../theme/app_theme.dart';
//import '../widgets/auth_widgets.dart';
import 'Q1 App theme.dart';
import 'Q1 Auth service.dart';
import 'Q1 Auth widgets.dart';
import 'Q1 Forgot password screen.dart';
import 'Q1 Signup screen.dart';
//import 'signup_screen.dart';
//import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();

  final _authService = AuthService();
  bool _isLoading = false;

  late AnimationController _animCtrl;
  late Animation<double>    _fadeAnim;
  late Animation<Offset>    _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  // ─── Login handler ─────────────────────────────────────────────────────────
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithEmail(
        email: _emailCtrl.text,
        password: _passCtrl.text,
      );
      // AuthWrapper handles navigation automatically via stream
    } on FirebaseAuthException catch (e) {
      if (mounted) showErrorSnackBar(context, _authService.getErrorMessage(e));
    } catch (_) {
      if (mounted) showErrorSnackBar(context, 'Something went wrong. Try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Stack(
          children: [
            const AccentOrb(size: 350, alignment: Alignment.topRight),
            const AccentOrb(size: 200, alignment: Alignment.bottomLeft),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Logo / Brand ─────────────────────────────────
                            _buildBrand(),
                            const SizedBox(height: 48),

                            // ── Heading ──────────────────────────────────────
                            Text(
                              'Welcome\nback.',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Sign in to continue.',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // ── Email ─────────────────────────────────────────
                            AuthTextField(
                              controller: _emailCtrl,
                              hintText: 'Email address',
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Email is required';
                                }
                                if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,}$')
                                    .hasMatch(v.trim())) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // ── Password ──────────────────────────────────────
                            AuthTextField(
                              controller: _passCtrl,
                              hintText: 'Password',
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Password is required';
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // ── Forgot password ───────────────────────────────
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ForgotPasswordScreen(),
                                  ),
                                ),
                                child: const Text('Forgot password?'),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // ── Sign In Button ────────────────────────────────
                            PrimaryButton(
                              label: 'Sign In',
                              onPressed: _login,
                              isLoading: _isLoading,
                            ),
                            const SizedBox(height: 32),

                            // ── Sign Up redirect ──────────────────────────────
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Create account',
                                      style: TextStyle(
                                        color: AppTheme.accentLight,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.accent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.bolt, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        const Text(
          'AuthKit',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}