// lib/presentation/screens/auth/signup_screen.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/password_helper.dart';
import '../../../data/database/database_helper.dart';
import '../../../data/models/user_model.dart';
import '../../widgets/common_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isLoading = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim().toLowerCase();
      final emailTaken = await _dbHelper.emailExists(email);

      if (emailTaken) {
        if (mounted) {
          showSnackBar(
              context, 'This email is already registered. Please login.',
              isError: true);
        }
        return;
      }

      final user = UserModel(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: email,
        passwordHash: PasswordHelper.hashPassword(_passwordController.text),
      );

      await _dbHelper.insertUser(user);

      if (mounted) {
        showSnackBar(
            context, 'Account created successfully! Please login.');
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Registration failed. Please try again.',
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const EcorpLogo(size: 65),
                  const SizedBox(height: 24),
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
                            'Create Account',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Join ECORP and start preparing today',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textGrey,
                            ),
                          ),
                          const SizedBox(height: 22),
                          // First Name
                          CustomTextField(
                            controller: _firstNameController,
                            hintText: 'First Name',
                            prefixIcon: Icons.person_outline,
                            validator: Validators.validateFirstName,
                            focusNode: _firstNameFocus,
                            nextFocusNode: _lastNameFocus,
                          ),
                          const SizedBox(height: 14),
                          // Last Name
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: 'Last Name',
                            prefixIcon: Icons.person_outline,
                            validator: Validators.validateLastName,
                            focusNode: _lastNameFocus,
                            nextFocusNode: _emailFocus,
                          ),
                          const SizedBox(height: 14),
                          // Email
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateEmail,
                            focusNode: _emailFocus,
                            nextFocusNode: _passwordFocus,
                          ),
                          const SizedBox(height: 14),
                          // Password
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            validator: Validators.validatePassword,
                            focusNode: _passwordFocus,
                            nextFocusNode: _confirmPasswordFocus,
                          ),
                          const SizedBox(height: 10),
                          // Password hint
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.inputBg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '✓ Min 6 characters  ✓ Letters + numbers',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.textGrey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Confirm Password
                          CustomTextField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            validator: (v) => Validators.validateConfirmPassword(
                                v, _passwordController.text),
                            focusNode: _confirmPasswordFocus,
                          ),
                          const SizedBox(height: 24),
                          PrimaryButton(
                            text: 'CREATE ACCOUNT',
                            onPressed: _signup,
                            isLoading: _isLoading,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    color: AppTheme.textGrey,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'LOGIN',
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
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
