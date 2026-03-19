import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Animated Button Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const AnimatedButtonScreen(),
//     );
//   }
// }

class AnimatedButtonScreen extends StatelessWidget {
  const AnimatedButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Press the button',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 48),
            AnimatedPressButton(
              label: 'TAP ME',
            ),
            SizedBox(height: 40),
            AnimatedPressButton(
              label: 'LAUNCH',
              defaultColor: Color(0xFF1B4332),
              pressedColor: Color(0xFF52B788),
              defaultSize: 180,
              pressedSize: 220,
              borderRadius: 50,
            ),
            SizedBox(height: 40),
            AnimatedPressButton(
              label: '♥ LIKE',
              defaultColor: Color(0xFF3A0A0A),
              pressedColor: Color(0xFFE63946),
              defaultSize: 160,
              pressedSize: 200,
              borderRadius: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedPressButton extends StatefulWidget {
  final String label;
  final Color defaultColor;
  final Color pressedColor;
  final double defaultSize;
  final double pressedSize;
  final double borderRadius;

  const AnimatedPressButton({
    super.key,
    required this.label,
    this.defaultColor = const Color(0xFF1A1A3E),
    this.pressedColor = const Color(0xFF6C63FF),
    this.defaultSize = 160,
    this.pressedSize = 200,
    this.borderRadius = 16,
  });

  @override
  State<AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<AnimatedPressButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        // 🔑 Implicit animation: duration & curve drive all changes automatically
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,

        width: _isPressed ? widget.pressedSize : widget.defaultSize,
        height: _isPressed ? widget.pressedSize * 0.35 : widget.defaultSize * 0.30,

        decoration: BoxDecoration(
          color: _isPressed ? widget.pressedColor : widget.defaultColor,
          borderRadius: BorderRadius.circular(
            _isPressed ? widget.borderRadius * 1.5 : widget.borderRadius,
          ),
          boxShadow: _isPressed
              ? [
            BoxShadow(
              color: widget.pressedColor.withOpacity(0.5),
              blurRadius: 30,
              spreadRadius: 4,
            )
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(
            color: _isPressed
                ? widget.pressedColor
                : widget.pressedColor.withOpacity(0.2),
            width: _isPressed ? 2 : 1,
          ),
        ),

        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            style: TextStyle(
              color: _isPressed ? Colors.white : Colors.white60,
              fontSize: _isPressed ? 16 : 14,
              fontWeight:
              _isPressed ? FontWeight.bold : FontWeight.w500,
              letterSpacing: _isPressed ? 3 : 2,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}