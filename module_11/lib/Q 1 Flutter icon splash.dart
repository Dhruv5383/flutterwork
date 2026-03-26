// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// // void main() {
// //   runApp(const IconSplashShowcase());
// // }
// //
// // // ─────────────────────────────────────────────
// // //  Root App
// // // ─────────────────────────────────────────────
// // class IconSplashShowcase extends StatelessWidget {
// //   const IconSplashShowcase({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Nova – App Icon & Splash',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: const Color(0xFF6C63FF),
// //           brightness: Brightness.dark,
// //         ),
// //         useMaterial3: true,
// //       ),
// //       home: const SplashScreen(),
// //     );
// //   }
// // }
//
// // ─────────────────────────────────────────────
// //  Splash Screen
// // ─────────────────────────────────────────────
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late final AnimationController _orbitCtrl;
//   late final AnimationController _entryCtrl;
//   late final AnimationController _pulseCtrl;
//
//   late final Animation<double> _scaleLogo;
//   late final Animation<double> _fadeTitle;
//   late final Animation<double> _slideTitle;
//   late final Animation<double> _fadeTagline;
//   late final Animation<double> _pulse;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _orbitCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 12),
//     )..repeat();
//
//     _pulseCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     )..repeat(reverse: true);
//
//     _pulse = Tween<double>(begin: 0.92, end: 1.08).animate(
//       CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
//     );
//
//     _entryCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//
//     _scaleLogo = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _entryCtrl,
//         curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
//       ),
//     );
//
//     _fadeTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _entryCtrl,
//         curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
//       ),
//     );
//
//     _slideTitle = Tween<double>(begin: 30.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _entryCtrl,
//         curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
//       ),
//     );
//
//     _fadeTagline = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _entryCtrl,
//         curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     Future.delayed(const Duration(milliseconds: 200), () {
//       _entryCtrl.forward();
//     });
//
//     Future.delayed(const Duration(seconds: 3), () {
//       if (mounted) {
//         Navigator.of(context).pushReplacement(
//           PageRouteBuilder(
//             transitionDuration: const Duration(milliseconds: 700),
//             pageBuilder: (_, __, ___) => const IconShowcasePage(),
//             transitionsBuilder: (_, animation, __, child) {
//               return FadeTransition(opacity: animation, child: child);
//             },
//           ),
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _orbitCtrl.dispose();
//     _entryCtrl.dispose();
//     _pulseCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0D0D1A),
//               Color(0xFF1A0D2E),
//               Color(0xFF0D1A2E),
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Ambient orbs
//             Positioned(
//               top: -80,
//               left: -60,
//               child: _AmbientOrb(
//                 color: const Color(0xFF6C63FF).withOpacity(0.18),
//                 size: 280,
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               right: -80,
//               child: _AmbientOrb(
//                 color: const Color(0xFF00D4FF).withOpacity(0.12),
//                 size: 320,
//               ),
//             ),
//             // Orbiting particles
//             Positioned.fill(
//               child: AnimatedBuilder(
//                 animation: _orbitCtrl,
//                 builder: (_, __) => CustomPaint(
//                   painter: _OrbitPainter(_orbitCtrl.value),
//                 ),
//               ),
//             ),
//             // Center content
//             Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Logo
//                   AnimatedBuilder(
//                     animation: Listenable.merge([_scaleLogo, _pulse]),
//                     builder: (_, __) => Transform.scale(
//                       scale: _scaleLogo.value * _pulse.value,
//                       child: const AppIconWidget(size: 120),
//                     ),
//                   ),
//                   const SizedBox(height: 36),
//                   // App name
//                   AnimatedBuilder(
//                     animation: _fadeTitle,
//                     builder: (_, __) => Opacity(
//                       opacity: _fadeTitle.value,
//                       child: Transform.translate(
//                         offset: Offset(0, _slideTitle.value),
//                         child: const Text(
//                           'NOVA',
//                           style: TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.w900,
//                             letterSpacing: 14,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Tagline
//                   AnimatedBuilder(
//                     animation: _fadeTagline,
//                     builder: (_, __) => Opacity(
//                       opacity: _fadeTagline.value,
//                       child: const Text(
//                         'Beyond the horizon',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w300,
//                           letterSpacing: 4,
//                           color: Color(0xFF9B93FF),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 72),
//                   // Loading dots
//                   AnimatedBuilder(
//                     animation: _fadeTagline,
//                     builder: (_, __) => Opacity(
//                       opacity: _fadeTagline.value,
//                       child: const _LoadingDots(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  Icon Showcase Page
// // ─────────────────────────────────────────────
// class IconShowcasePage extends StatelessWidget {
//   const IconShowcasePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D1A),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'App Icons',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.w800,
//                   letterSpacing: 1,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               const Text(
//                 'All sizes · All platforms',
//                 style: TextStyle(
//                   color: Color(0xFF9B93FF),
//                   fontSize: 14,
//                   letterSpacing: 2,
//                 ),
//               ),
//               const SizedBox(height: 40),
//
//               // iOS sizes
//               _SectionLabel(label: 'iOS / iPadOS'),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 20,
//                 runSpacing: 24,
//                 children: [
//                   _IconTile(size: 20, label: '20pt\n1×'),
//                   _IconTile(size: 29, label: '29pt\nSettings'),
//                   _IconTile(size: 40, label: '40pt\nSpotlight'),
//                   _IconTile(size: 60, label: '60pt\nApp'),
//                   _IconTile(size: 76, label: '76pt\niPad'),
//                   _IconTile(size: 96, label: '96pt\niPad Pro'),
//                 ],
//               ),
//
//               const SizedBox(height: 48),
//
//               // Android sizes
//               _SectionLabel(label: 'Android'),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 20,
//                 runSpacing: 24,
//                 children: [
//                   _IconTile(size: 36, label: 'ldpi\n36px'),
//                   _IconTile(size: 48, label: 'mdpi\n48px'),
//                   _IconTile(size: 72, label: 'hdpi\n72px'),
//                   _IconTile(size: 96, label: 'xhdpi\n96px'),
//                   _IconTile(size: 108, label: 'xxhdpi\n108px'),
//                 ],
//               ),
//
//               const SizedBox(height: 48),
//
//               // macOS / Web
//               _SectionLabel(label: 'macOS / Web / PWA'),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 20,
//                 runSpacing: 24,
//                 children: [
//                   _IconTile(size: 32, label: '32px'),
//                   _IconTile(size: 48, label: '48px'),
//                   _IconTile(size: 64, label: '64px'),
//                   _IconTile(size: 128, label: '128px'),
//                 ],
//               ),
//
//               const SizedBox(height: 56),
//
//               // Splash preview button
//               Center(
//                 child: _GlowButton(
//                   label: 'Preview Splash Screen',
//                   onTap: () {
//                     Navigator.of(context).push(
//                       PageRouteBuilder(
//                         transitionDuration: const Duration(milliseconds: 500),
//                         pageBuilder: (_, __, ___) => const SplashScreen(),
//                         transitionsBuilder: (_, anim, __, child) =>
//                             FadeTransition(opacity: anim, child: child),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  Core App Icon Widget  (reusable at any size)
// // ─────────────────────────────────────────────
// class AppIconWidget extends StatelessWidget {
//   final double size;
//   final double cornerRadiusFraction; // 0‥1, fraction of size
//
//   const AppIconWidget({
//     super.key,
//     required this.size,
//     this.cornerRadiusFraction = 0.2237, // iOS squircle approximation
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final r = size * cornerRadiusFraction;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(r),
//       child: SizedBox(
//         width: size,
//         height: size,
//         child: CustomPaint(
//           painter: _IconPainter(size: size),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────
// //  Icon Painter
// // ─────────────────────────────────────────────
// class _IconPainter extends CustomPainter {
//   final double size;
//   _IconPainter({required this.size});
//
//   @override
//   void paint(Canvas canvas, Size canvasSize) {
//     final s = canvasSize.width;
//     final cx = s / 2;
//     final cy = s / 2;
//
//     // Background gradient
//     final bgPaint = Paint()
//       ..shader = const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF1A0938), Color(0xFF0D1A3E), Color(0xFF0A0D1F)],
//       ).createShader(Rect.fromLTWH(0, 0, s, s));
//     canvas.drawRect(Rect.fromLTWH(0, 0, s, s), bgPaint);
//
//     // Glow circle behind star
//     final glowPaint = Paint()
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28)
//       ..color = const Color(0xFF6C63FF).withOpacity(0.5);
//     canvas.drawCircle(Offset(cx, cy), s * 0.28, glowPaint);
//
//     // Outer ring
//     final ringPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = s * 0.025
//       ..shader = const SweepGradient(
//         colors: [Color(0xFF6C63FF), Color(0xFF00D4FF), Color(0xFF6C63FF)],
//       ).createShader(Rect.fromLTWH(0, 0, s, s));
//     canvas.drawCircle(Offset(cx, cy), s * 0.38, ringPaint);
//
//     // Small orbiting dot
//     final dotAngle = math.pi / 4;
//     final dotX = cx + s * 0.38 * math.cos(dotAngle);
//     final dotY = cy + s * 0.38 * math.sin(dotAngle);
//     final dotPaint = Paint()..color = const Color(0xFF00D4FF);
//     canvas.drawCircle(Offset(dotX, dotY), s * 0.04, dotPaint);
//
//     // 4-pointed star
//     _drawStar(canvas, Offset(cx, cy), s * 0.22, s * 0.09, 4);
//   }
//
//   void _drawStar(
//       Canvas canvas, Offset center, double outer, double inner, int points) {
//     final path = Path();
//     final angle = (math.pi * 2) / points;
//
//     for (int i = 0; i < points * 2; i++) {
//       final r = i.isEven ? outer : inner;
//       final a = i * angle / 2 - math.pi / 2;
//       final x = center.dx + r * math.cos(a);
//       final y = center.dy + r * math.sin(a);
//       i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
//     }
//     path.close();
//
//     final starPaint = Paint()
//       ..shader = const LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [Color(0xFFFFFFFF), Color(0xFF9B93FF)],
//       ).createShader(
//         Rect.fromCircle(center: center, radius: outer),
//       );
//     canvas.drawPath(path, starPaint);
//
//     // Star glow
//     final starGlow = Paint()
//       ..style = PaintingStyle.fill
//       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
//       ..color = Colors.white.withOpacity(0.3);
//     canvas.drawPath(path, starGlow);
//   }
//
//   @override
//   bool shouldRepaint(covariant _IconPainter old) => old.size != size;
// }
//
// // ─────────────────────────────────────────────
// //  Orbit Painter (splash screen particles)
// // ─────────────────────────────────────────────
// class _OrbitPainter extends CustomPainter {
//   final double progress;
//   _OrbitPainter(this.progress);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final cx = size.width / 2;
//     final cy = size.height / 2;
//     final rng = math.Random(42);
//
//     final particlePaint = Paint()..style = PaintingStyle.fill;
//
//     for (int i = 0; i < 18; i++) {
//       final speed = 0.3 + rng.nextDouble() * 0.7;
//       final radius =
//           size.width * (0.18 + rng.nextDouble() * 0.38);
//       final angle =
//           (progress * speed * math.pi * 2) + (i / 18.0) * math.pi * 2;
//       final x = cx + radius * math.cos(angle);
//       final y = cy + radius * math.sin(angle) * 0.55;
//       final dotSize = 1.5 + rng.nextDouble() * 2.5;
//       final opacity = 0.15 + rng.nextDouble() * 0.45;
//
//       particlePaint.color = (i % 3 == 0
//           ? const Color(0xFF6C63FF)
//           : i % 3 == 1
//           ? const Color(0xFF00D4FF)
//           : Colors.white)
//           .withOpacity(opacity);
//
//       canvas.drawCircle(Offset(x, y), dotSize, particlePaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _OrbitPainter old) => old.progress != progress;
// }
//
// // ─────────────────────────────────────────────
// //  Helper Widgets
// // ─────────────────────────────────────────────
// class _AmbientOrb extends StatelessWidget {
//   final Color color;
//   final double size;
//   const _AmbientOrb({required this.color, required this.size});
//
//   @override
//   Widget build(BuildContext context) => Container(
//     width: size,
//     height: size,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: color,
//       boxShadow: [BoxShadow(color: color, blurRadius: size * 0.6)],
//     ),
//   );
// }
//
// class _LoadingDots extends StatefulWidget {
//   const _LoadingDots();
//
//   @override
//   State<_LoadingDots> createState() => _LoadingDotsState();
// }
//
// class _LoadingDotsState extends State<_LoadingDots>
//     with TickerProviderStateMixin {
//   late final List<AnimationController> _controllers;
//   late final List<Animation<double>> _anims;
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers = List.generate(
//       3,
//           (i) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 600),
//       )..repeat(
//         reverse: true,
//         period: const Duration(milliseconds: 900),
//       ),
//     );
//     _anims = _controllers
//         .map((c) => Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: c, curve: Curves.easeInOut),
//     ))
//         .toList();
//
//     for (int i = 0; i < 3; i++) {
//       Future.delayed(Duration(milliseconds: i * 200), () {
//         if (mounted) _controllers[i].forward();
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     for (final c in _controllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(3, (i) {
//         return AnimatedBuilder(
//           animation: _anims[i],
//           builder: (_, __) => Container(
//             margin: const EdgeInsets.symmetric(horizontal: 4),
//             width: 6,
//             height: 6,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Color.lerp(
//                 const Color(0xFF6C63FF).withOpacity(0.3),
//                 const Color(0xFF00D4FF),
//                 _anims[i].value,
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class _SectionLabel extends StatelessWidget {
//   final String label;
//   const _SectionLabel({required this.label});
//
//   @override
//   Widget build(BuildContext context) => Row(
//     children: [
//       Container(
//         width: 3,
//         height: 18,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(2),
//           gradient: const LinearGradient(
//             colors: [Color(0xFF6C63FF), Color(0xFF00D4FF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//       ),
//       const SizedBox(width: 10),
//       Text(
//         label,
//         style: const TextStyle(
//           color: Colors.white70,
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 2.5,
//         ),
//       ),
//     ],
//   );
// }
//
// class _IconTile extends StatelessWidget {
//   final double size;
//   final String label;
//   const _IconTile({required this.size, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AppIconWidget(size: size.clamp(20, 128)),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             color: Color(0xFF6B6B8A),
//             fontSize: 10,
//             height: 1.4,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _GlowButton extends StatefulWidget {
//   final String label;
//   final VoidCallback onTap;
//   const _GlowButton({required this.label, required this.onTap});
//
//   @override
//   State<_GlowButton> createState() => _GlowButtonState();
// }
//
// class _GlowButtonState extends State<_GlowButton> {
//   bool _pressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _pressed = true),
//       onTapUp: (_) {
//         setState(() => _pressed = false);
//         widget.onTap();
//       },
//       onTapCancel: () => setState(() => _pressed = false),
//       child: AnimatedScale(
//         scale: _pressed ? 0.95 : 1.0,
//         duration: const Duration(milliseconds: 120),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(50),
//             gradient: const LinearGradient(
//               colors: [Color(0xFF6C63FF), Color(0xFF00D4FF)],
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF6C63FF).withOpacity(0.45),
//                 blurRadius: 24,
//                 offset: const Offset(0, 8),
//               ),
//             ],
//           ),
//           child: Text(
//             widget.label,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 1.5,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








import 'dart:math' as math;
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
//       title: 'Nova',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(useMaterial3: true),
//       home: const SplashScreen(),
//     );
//   }
// }

// ══════════════════════════════════════════════
//  SPLASH SCREEN
// ══════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleLogo;
  late final Animation<double> _fadeText;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleLogo = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    );

    _fadeText = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _ctrl.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ShowcasePage()),
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D0D1A), Color(0xFF1A0D2E), Color(0xFF0D1A2E)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleLogo,
              child: const NovaIcon(size: 120),
            ),
            const SizedBox(height: 40),
            FadeTransition(
              opacity: _fadeText,
              child: const Column(
                children: [
                  Text(
                    'NOVA',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 12,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Beyond the horizon',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4,
                      color: Color(0xFF9B93FF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            FadeTransition(
              opacity: _fadeText,
              child: const _PulsingDot(),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
//  SHOWCASE PAGE
// ══════════════════════════════════════════════
class ShowcasePage extends StatelessWidget {
  const ShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D1A),
        title: const Text(
          'App Icons',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('iOS / iPadOS'),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 20,
              runSpacing: 24,
              children: [
                _IconTile(size: 20, label: '20pt'),
                _IconTile(size: 29, label: '29pt'),
                _IconTile(size: 40, label: '40pt'),
                _IconTile(size: 60, label: '60pt'),
                _IconTile(size: 76, label: '76pt'),
                _IconTile(size: 120, label: '120pt'),
              ],
            ),
            const SizedBox(height: 40),
            _sectionLabel('Android'),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 20,
              runSpacing: 24,
              children: [
                _IconTile(size: 36, label: 'ldpi'),
                _IconTile(size: 48, label: 'mdpi'),
                _IconTile(size: 72, label: 'hdpi'),
                _IconTile(size: 96, label: 'xhdpi'),
                _IconTile(size: 108, label: 'xxhdpi'),
              ],
            ),
            const SizedBox(height: 40),
            _sectionLabel('macOS / Web / PWA'),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 20,
              runSpacing: 24,
              children: [
                _IconTile(size: 32, label: '32px'),
                _IconTile(size: 64, label: '64px'),
                _IconTile(size: 128, label: '128px'),
              ],
            ),
            const SizedBox(height: 48),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16),
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Preview Splash Screen',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, letterSpacing: 1),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFF9B93FF),
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 3,
      ),
    );
  }
}

// ══════════════════════════════════════════════
//  NOVA ICON  (CustomPainter — works at any size)
// ══════════════════════════════════════════════
class NovaIcon extends StatelessWidget {
  final double size;

  const NovaIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final radius = size * 0.2237; // iOS squircle approximation
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _NovaPainter()),
      ),
    );
  }
}

class _NovaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    // Background gradient
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B0A3F), Color(0xFF0D1A3E), Color(0xFF080D20)],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Purple glow behind star
    canvas.drawCircle(
      Offset(cx, cy),
      w * 0.28,
      Paint()
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.18)
        ..color = const Color(0xFF6C63FF).withOpacity(0.6),
    );

    // Orbit ring
    canvas.drawCircle(
      Offset(cx, cy),
      w * 0.36,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.022
        ..shader = SweepGradient(
          colors: const [
            Color(0xFF6C63FF),
            Color(0xFF00D4FF),
            Color(0xFF6C63FF),
          ],
        ).createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Orbiting dot
    final dotAngle = math.pi * 0.75;
    final dotX = cx + w * 0.36 * math.cos(dotAngle);
    final dotY = cy + w * 0.36 * math.sin(dotAngle);

    // Dot glow
    canvas.drawCircle(
      Offset(dotX, dotY),
      w * 0.06,
      Paint()
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.04)
        ..color = const Color(0xFF00D4FF).withOpacity(0.5),
    );
    // Dot solid
    canvas.drawCircle(
      Offset(dotX, dotY),
      w * 0.042,
      Paint()..color = const Color(0xFF00D4FF),
    );

    // 4-pointed star
    _drawStar(canvas, Offset(cx, cy), w * 0.22, w * 0.09, 4);
  }

  void _drawStar(
      Canvas canvas, Offset center, double outer, double inner, int points) {
    final path = Path();
    final total = points * 2;
    for (int i = 0; i < total; i++) {
      final r = i.isEven ? outer : inner;
      final a = (i * math.pi / points) - math.pi / 2;
      final x = center.dx + r * math.cos(a);
      final y = center.dy + r * math.sin(a);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();

    // White-to-purple gradient fill
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, const Color(0xFF9B93FF)],
        ).createShader(Rect.fromCircle(center: center, radius: outer)),
    );

    // Soft glow overlay
    canvas.drawPath(
      path,
      Paint()
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, outer * 0.3)
        ..color = Colors.white.withOpacity(0.25),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ══════════════════════════════════════════════
//  HELPERS
// ══════════════════════════════════════════════
class _IconTile extends StatelessWidget {
  final double size;
  final String label;

  const _IconTile({required this.size, required this.label});

  @override
  Widget build(BuildContext context) {
    final display = size.clamp(24.0, 130.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NovaIcon(size: display),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF6B6B8A), fontSize: 11),
        ),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
      ),
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF6C63FF),
        ),
      ),
    );
  }
}