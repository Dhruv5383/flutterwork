import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Q1 App theme.dart';
import 'Q1 Auth service.dart';
import 'Q1 Auth widgets.dart';
//import '../services/auth_service.dart';
//import '../theme/app_theme.dart';
//import '../widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey   = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  final _confirmCtrl = TextEditingController();

  final _authService = AuthService();
  bool _isLoading = false;
  bool _agreeToTerms = false;

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
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  // ─── Sign Up handler ──────────────────────────────────────────────────────
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      showErrorSnackBar(context, 'Please agree to the Terms & Privacy Policy.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signUpWithEmail(
        email: _emailCtrl.text,
        password: _passCtrl.text,
        displayName: _nameCtrl.text,
      );

      if (mounted) {
        showSuccessSnackBar(
            context, 'Account created! Check your email for verification.');
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) showErrorSnackBar(context, _authService.getErrorMessage(e));
    } catch (_) {
      if (mounted) showErrorSnackBar(context, 'Something went wrong. Try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ─── Password strength indicator ─────────────────────────────────────────
  double _passwordStrength(String password) {
    if (password.isEmpty) return 0;
    double score = 0;
    if (password.length >= 8) score += 0.25;
    if (password.length >= 12) score += 0.15;
    if (RegExp(r'[A-Z]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[0-9]').hasMatch(password)) score += 0.2;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(password)) score += 0.2;
    return score.clamp(0.0, 1.0);
  }

  Color _strengthColor(double strength) {
    if (strength < 0.4) return AppTheme.error;
    if (strength < 0.7) return Colors.orange;
    return AppTheme.success;
  }

  String _strengthLabel(double strength) {
    if (strength < 0.4) return 'Weak';
    if (strength < 0.7) return 'Fair';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Stack(
          children: [
            const AccentOrb(size: 300, alignment: Alignment.topLeft),
            const AccentOrb(size: 180, alignment: Alignment.bottomRight),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Back + Title ─────────────────────────────────
                          Row(
                            children: [
                              _BackButton(),
                              const SizedBox(width: 12),
                              const Text(
                                'Create account',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),

                          Text(
                            'Join us\ntoday.',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create your free account.',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 36),

                          // ── Name ──────────────────────────────────────────
                          AuthTextField(
                            controller: _nameCtrl,
                            hintText: 'Full name',
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                          ),
                          const SizedBox(height: 16),

                          // ── Email ─────────────────────────────────────────
                          AuthTextField(
                            controller: _emailCtrl,
                            hintText: 'Email address',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Email is required';
                              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,}$')
                                  .hasMatch(v.trim())) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── Password ──────────────────────────────────────
                          ValueListenableBuilder(
                            valueListenable: _passCtrl,
                            builder: (_, TextEditingValue val, __) {
                              final strength = _passwordStrength(val.text);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AuthTextField(
                                    controller: _passCtrl,
                                    hintText: 'Password',
                                    prefixIcon: Icons.lock_outline,
                                    isPassword: true,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'Password is required';
                                      if (v.length < 6) return 'Minimum 6 characters';
                                      return null;
                                    },
                                  ),
                                  if (val.text.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: LinearProgressIndicator(
                                              value: strength,
                                              backgroundColor: AppTheme.border,
                                              color: _strengthColor(strength),
                                              minHeight: 4,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          _strengthLabel(strength),
                                          style: TextStyle(
                                            color: _strengthColor(strength),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── Confirm Password ──────────────────────────────
                          AuthTextField(
                            controller: _confirmCtrl,
                            hintText: 'Confirm password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Please confirm your password';
                              if (v != _passCtrl.text) return 'Passwords do not match';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // ── Terms checkbox ────────────────────────────────
                          _TermsCheckbox(
                            value: _agreeToTerms,
                            onChanged: (v) => setState(() => _agreeToTerms = v ?? false),
                          ),
                          const SizedBox(height: 28),

                          // ── Create Account button ─────────────────────────
                          PrimaryButton(
                            label: 'Create Account',
                            onPressed: _signUp,
                            isLoading: _isLoading,
                          ),
                          const SizedBox(height: 28),

                          // ── Sign in redirect ──────────────────────────────
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Sign in',
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
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.surfaceAlt,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.border),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppTheme.textPrimary,
          size: 16,
        ),
      ),
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  const _TermsCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.accent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: const BorderSide(color: AppTheme.border, width: 1.5),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'I agree to the Terms of Service and Privacy Policy.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}