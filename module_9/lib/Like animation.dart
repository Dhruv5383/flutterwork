import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Like Animation',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0E0E16),
//       ),
//       home: const LikeShowcase(),
//     );
//   }
// }

// ════════════════════════════════════════════════
//  SHOWCASE SCREEN
// ════════════════════════════════════════════════
class LikeShowcase extends StatelessWidget {
  const LikeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E16),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          children: const [
            _Header(),
            SizedBox(height: 24),
            _PostCard(
              username: 'aurora.lens',
              handle: '@aurora',
              avatarColor: Color(0xFFFF6B9D),
              imageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
              caption: 'Golden hour never disappoints 🏔️✨',
              initialLikes: 4821,
            ),
            SizedBox(height: 20),
            _PostCard(
              username: 'oceandrift',
              handle: '@oceandrift',
              avatarColor: Color(0xFF4ECDC4),
              imageUrl:
              'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=800',
              caption: 'Lost at sea, found myself 🌊',
              initialLikes: 12043,
            ),
            SizedBox(height: 20),
            _PostCard(
              username: 'forest.ghost',
              handle: '@forestghost',
              avatarColor: Color(0xFF95E77E),
              imageUrl:
              'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800',
              caption: 'Morning mist in the ancient woods 🌿',
              initialLikes: 7356,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B9D), Color(0xFFFF8E53)],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            '♥  NEW LIKE UI',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Tap the heart',
          style: TextStyle(
            color: Colors.white.withOpacity(0.35),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════
//  POST CARD
// ════════════════════════════════════════════════
class _PostCard extends StatelessWidget {
  final String username, handle, imageUrl, caption;
  final Color avatarColor;
  final int initialLikes;

  const _PostCard({
    required this.username,
    required this.handle,
    required this.avatarColor,
    required this.imageUrl,
    required this.caption,
    required this.initialLikes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161622),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                _Avatar(color: avatarColor, name: username),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                    Text(handle,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.35),
                            fontSize: 12)),
                  ],
                ),
                const Spacer(),
                Icon(Icons.more_horiz_rounded,
                    color: Colors.white.withOpacity(0.3)),
              ],
            ),
          ),
          // Image — double-tap to like
          _DoubleTapImage(imageUrl: imageUrl),
          // Action bar
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
            child: _ActionBar(initialLikes: initialLikes),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: '$username ',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
                TextSpan(
                    text: caption,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 13)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final Color color;
  final String name;
  const _Avatar({required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  DOUBLE-TAP IMAGE (shows floating heart)
// ════════════════════════════════════════════════
class _DoubleTapImage extends StatefulWidget {
  final String imageUrl;
  const _DoubleTapImage({required this.imageUrl});
  @override
  State<_DoubleTapImage> createState() => _DoubleTapImageState();
}

class _DoubleTapImageState extends State<_DoubleTapImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;
  bool _show = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _scale = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.3, end: 1.25)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 1.25, end: 1.0)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 20),
    ]).animate(_ctrl);
    _opacity = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    HapticFeedback.mediumImpact();
    setState(() => _show = true);
    _ctrl.forward(from: 0).then((_) {
      if (mounted) setState(() => _show = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(widget.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, p) => p == null
                    ? child
                    : Container(
                    color: const Color(0xFF1A1A28),
                    child: const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFFFF6B9D), strokeWidth: 2)))),
            if (_show)
              Center(
                child: AnimatedBuilder(
                  animation: _ctrl,
                  builder: (_, __) => Opacity(
                    opacity: _opacity.value,
                    child: Transform.scale(
                      scale: _scale.value,
                      child: const _HeartIcon(size: 90, color: Colors.white),
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

// ════════════════════════════════════════════════
//  ACTION BAR (Like · Comment · Share · Save)
// ════════════════════════════════════════════════
class _ActionBar extends StatelessWidget {
  final int initialLikes;
  const _ActionBar({required this.initialLikes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeButton(initialCount: initialLikes),
        const SizedBox(width: 4),
        _IconBtn(icon: Icons.chat_bubble_outline_rounded, onTap: () {}),
        const SizedBox(width: 4),
        _IconBtn(icon: Icons.send_outlined, onTap: () {}),
        const Spacer(),
        _IconBtn(icon: Icons.bookmark_border_rounded, onTap: () {}),
      ],
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child:
        Icon(icon, color: Colors.white.withOpacity(0.6), size: 22),
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  LIKE BUTTON — the star of the show
// ════════════════════════════════════════════════
class LikeButton extends StatefulWidget {
  final int initialCount;
  const LikeButton({super.key, required this.initialCount});
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  late bool _liked;
  late int _count;

  // Heart scale + bounce
  late final AnimationController _heartCtrl;
  late final Animation<double> _heartScale;

  // Particle burst
  late final AnimationController _burstCtrl;

  // Count slide
  late final AnimationController _countCtrl;
  late final Animation<Offset> _countSlideIn;
  late final Animation<Offset> _countSlideOut;
  late final Animation<double> _countFade;

  @override
  void initState() {
    super.initState();
    _liked = false;
    _count = widget.initialCount;

    // ── Heart ──────────────────────────────────
    _heartCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _heartScale = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.75)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 15),
      TweenSequenceItem(
          tween: Tween(begin: 0.75, end: 1.35)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 1.35, end: 0.95)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 25),
      TweenSequenceItem(
          tween: Tween(begin: 0.95, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 20),
    ]).animate(_heartCtrl);

    // ── Burst ──────────────────────────────────
    _burstCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    // ── Count ──────────────────────────────────
    _countCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _countSlideIn = Tween(begin: const Offset(0, 0.8), end: Offset.zero)
        .animate(CurvedAnimation(parent: _countCtrl, curve: Curves.easeOut));
    _countSlideOut =
        Tween(begin: Offset.zero, end: const Offset(0, -0.8)).animate(
            CurvedAnimation(parent: _countCtrl, curve: Curves.easeIn));
    _countFade = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _countCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _heartCtrl.dispose();
    _burstCtrl.dispose();
    _countCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    HapticFeedback.lightImpact();
    setState(() {
      _liked = !_liked;
      _count += _liked ? 1 : -1;
    });
    // Animate count
    _countCtrl.forward(from: 0);
    if (_liked) {
      // Animate heart + burst only on like
      _heartCtrl.forward(from: 0);
      _burstCtrl.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Particle burst
                  AnimatedBuilder(
                    animation: _burstCtrl,
                    builder: (_, __) => CustomPaint(
                      size: const Size(36, 36),
                      painter: _BurstPainter(
                        progress: _burstCtrl.value,
                        color: const Color(0xFFFF4D6D),
                        active: _liked,
                      ),
                    ),
                  ),
                  // Heart icon
                  AnimatedBuilder(
                    animation: _heartScale,
                    builder: (_, __) => Transform.scale(
                      scale: _heartScale.value,
                      child: _HeartIcon(
                        size: 26,
                        color: _liked
                            ? const Color(0xFFFF4D6D)
                            : Colors.white.withOpacity(0.55),
                        filled: _liked,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            // Animated count
            SizedBox(
              height: 20,
              child: AnimatedBuilder(
                animation: _countCtrl,
                builder: (_, __) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SlideTransition(
                      position: _countSlideIn,
                      child: FadeTransition(
                        opacity: _countFade,
                        child: Text(
                          _formatCount(_count),
                          style: TextStyle(
                            color: _liked
                                ? const Color(0xFFFF4D6D)
                                : Colors.white.withOpacity(0.55),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
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
    );
  }

  String _formatCount(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

// ════════════════════════════════════════════════
//  HEART ICON (filled / outline)
// ════════════════════════════════════════════════
class _HeartIcon extends StatelessWidget {
  final double size;
  final Color color;
  final bool filled;
  const _HeartIcon({required this.size, required this.color, this.filled = true});

  @override
  Widget build(BuildContext context) {
    return Icon(
      filled ? Icons.favorite_rounded : Icons.favorite_border_rounded,
      color: color,
      size: size,
    );
  }
}

// ════════════════════════════════════════════════
//  BURST PAINTER — particle explosion on like
// ════════════════════════════════════════════════
class _BurstPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool active;
  static const _particleCount = 8;
  static const _dotColors = [
    Color(0xFFFF4D6D),
    Color(0xFFFF8E53),
    Color(0xFFFFD166),
    Color(0xFFFF6B9D),
    Color(0xFFFF4D6D),
    Color(0xFFFF8E53),
    Color(0xFFFFD166),
    Color(0xFFFF6B9D),
  ];

  const _BurstPainter({
    required this.progress,
    required this.color,
    required this.active,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0 || !active) return;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < _particleCount; i++) {
      final angle = (2 * pi / _particleCount) * i - pi / 2;

      // Particles shoot out then fade
      final distance = 18 * Curves.easeOut.transform(progress);
      final opacity = progress < 0.6
          ? Curves.easeIn.transform(progress / 0.6)
          : 1.0 - Curves.easeIn.transform((progress - 0.6) / 0.4);

      final dotRadius = 3.0 * (1 - progress * 0.5);

      final x = center.dx + distance * cos(angle);
      final y = center.dy + distance * sin(angle);

      // Alternating dots and dashes
      if (i.isEven) {
        canvas.drawCircle(
          Offset(x, y),
          dotRadius,
          Paint()..color = _dotColors[i].withOpacity(opacity),
        );
      } else {
        final dx2 = center.dx + (distance + 4) * cos(angle);
        final dy2 = center.dy + (distance + 4) * sin(angle);
        canvas.drawLine(
          Offset(x, y),
          Offset(dx2, dy2),
          Paint()
            ..color = _dotColors[i].withOpacity(opacity)
            ..strokeWidth = 2
            ..strokeCap = StrokeCap.round,
        );
      }
    }

    // Expanding ring flash
    if (progress < 0.35) {
      final ringProgress = progress / 0.35;
      final ringRadius = 14 * ringProgress;
      final ringOpacity = 1.0 - ringProgress;
      canvas.drawCircle(
        center,
        ringRadius,
        Paint()
          ..color = color.withOpacity(ringOpacity * 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(_BurstPainter old) =>
      old.progress != progress || old.active != active;
}