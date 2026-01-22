import 'package:flutter/material.dart';

class GlowPulseButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const GlowPulseButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<GlowPulseButton> createState() => _GlowPulseButtonState();
}

class _GlowPulseButtonState extends State<GlowPulseButton> {
  bool _pulsing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        setState(() => _pulsing = true);
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 1.0,
          end: _pulsing ? 1.15 : 1.0,
        ),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubicEmphasized, // Material 3 motion
        onEnd: () {
          if (_pulsing) {
            setState(() => _pulsing = false);
          }
        },
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(_pulsing ? 0.6 : 0.3),
                    blurRadius: _pulsing ? 24 : 10,
                    spreadRadius: _pulsing ? 2 : 0,
                  ),
                ],
              ),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
