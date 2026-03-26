// lib/presentation/widgets/common_widgets.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Reusable ECORP logo widget.
class EcorpLogo extends StatelessWidget {
  final double size;
  const EcorpLogo({super.key, this.size = 70});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.accentOrange,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          child: Center(
            child: Text(
              'E',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.55,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'ECORP',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.38,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}

/// Reusable custom text field.
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon, color: AppTheme.primaryPurple),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.textGrey,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : null,
      ),
    );
  }
}

/// Reusable primary button.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(text),
      ),
    );
  }
}

/// Snackbar helper
void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? AppTheme.errorRed : AppTheme.successGreen,
      duration: const Duration(seconds: 3),
    ),
  );
}
