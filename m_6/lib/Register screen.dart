// lib/screens/register_screen.dart

import 'package:flutter/material.dart';
//import '../services/auth_service.dart';
//import '../utils/constants.dart';
import 'Auth service.dart';
import 'Constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _isLoading = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms & Conditions'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _isLoading = true);

    final result = await _authService.register(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully! 🎉'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['error'] ?? 'Registration failed'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Join MyCityConnect',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Create your account and start exploring city services',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 32),
              // Name
              TextFormField(
                controller: _nameCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Name is required';
                  if (v.trim().length < 2) return 'Enter a valid name';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Email
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Password
              TextFormField(
                controller: _passCtrl,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePass ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'Minimum 6 characters';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Confirm Password
              TextFormField(
                controller: _confirmPassCtrl,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please confirm your password';
                  if (v != _passCtrl.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Terms
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                    activeColor: AppColors.primary,
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        children: [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                                color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                color: AppColors.primary, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                      : const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 20),
              // Already have account
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: AppColors.textSecondary),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                              color: AppColors.primary, fontWeight: FontWeight.w700),
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
    );
  }
}