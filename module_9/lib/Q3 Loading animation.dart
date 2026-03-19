import 'dart:math';
import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Loading Animation Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0A0A12),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// ─────────────────────────────────────────────
// Simulated data model
// ─────────────────────────────────────────────
class Article {
  final String title, category, time, imageUrl;
  final Color accent;
  const Article({
    required this.title,
    required this.category,
    required this.time,
    required this.imageUrl,
    required this.accent,
  });
}

const _articles = [
  Article(
    title: 'The Future of Quantum Computing in 2025',
    category: 'Technology',
    time: '5 min read',
    imageUrl: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=400',
    accent: Color(0xFF7C6FCD),
  ),
  Article(
    title: 'Deep Ocean Discoveries That Shocked Scientists',
    category: 'Science',
    time: '8 min read',
    imageUrl: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?w=400',
    accent: Color(0xFF26C6DA),
  ),
  Article(
    title: 'Minimalist Architecture in Modern Cities',
    category: 'Design',
    time: '4 min read',
    imageUrl: 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=400',
    accent: Color(0xFFFFB74D),
  ),
  Article(
    title: 'How AI is Reshaping Creative Industries',
    category: 'AI',
    time: '6 min read',
    imageUrl: 'https://images.unsplash.com/photo-1677442135703-1787eea5ce01?w=400',
    accent: Color(0xFF66BB6A),
  ),
];

// ─────────────────────────────────────────────
// Home screen — toggles between loading & data
// ─────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  Future<void> _reload() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'DISCOVER',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
        actions: [
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white54),
              onPressed: _reload,
            ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _isLoading
            ? const _LoadingView(key: ValueKey('loading'))
            : const _DataView(key: ValueKey('data')),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOADING VIEW — skeleton + orbital spinner
// ─────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Central orbital loader
          const OrbitalLoader(),
          const SizedBox(height: 12),
          Text(
            'Fetching latest stories…',
            style: TextStyle(
              color: Colors.white.withOpacity(0.35),
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 40),
          // Skeleton cards
          ...List.generate(4, (i) => const _SkeletonCard()),
        ],
      ),
    );
  }
}

// ── Orbital spinner (3 rings, staggered) ──────
class OrbitalLoader extends StatefulWidget {
  const OrbitalLoader({super.key});

  @override
  State<OrbitalLoader> createState() => _OrbitalLoaderState();
}

class _OrbitalLoaderState extends State<OrbitalLoader>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _rotations;

  @override
  void initState() {
    super.initState();
    // Three rings: different speeds & directions
    final configs = [
      (duration: 1200, reverse: false),
      (duration: 1800, reverse: true),
      (duration: 2400, reverse: false),
    ];
    _controllers = configs
        .map((c) => AnimationController(
      vsync: this,
      duration: Duration(milliseconds: c.duration),
    )..repeat(reverse: c.reverse))
        .toList();
    _rotations = _controllers
        .map((c) => Tween(begin: 0.0, end: 2 * pi).animate(c))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFF7C6FCD), Color(0xFF26C6DA), Color(0xFFFFB74D)];
    const sizes = [80.0, 56.0, 32.0];

    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glowing core
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          // Rings
          ...List.generate(3, (i) {
            return AnimatedBuilder(
              animation: _rotations[i],
              builder: (_, __) => Transform.rotate(
                angle: _rotations[i].value,
                child: SizedBox(
                  width: sizes[i],
                  height: sizes[i],
                  child: CustomPaint(
                    painter: _RingPainter(color: colors[i]),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  const _RingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Faded ring track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color.withOpacity(0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Glowing arc (90 degrees)
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [color.withOpacity(0), color],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi / 2,
      false,
      paint,
    );

    // Leading dot
    final dotAngle = 0.0; // top of arc
    final dx = center.dx + radius * cos(-pi / 2);
    final dy = center.dy + radius * sin(-pi / 2);
    canvas.drawCircle(
      Offset(dx, dy),
      3,
      Paint()
        ..color = color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.color != color;
}

// ── Skeleton shimmer card ─────────────────────
class _SkeletonCard extends StatefulWidget {
  const _SkeletonCard();

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _shimmer = Tween(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _bone(double w, double h, {double radius = 8}) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, __) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.0, 0.5, 1.0],
            colors: const [
              Color(0xFF1E1E2E),
              Color(0xFF2A2A3E),
              Color(0xFF1E1E2E),
            ],
            transform: _SlidingGradient(_shimmer.value),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF131320),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          _bone(90, 90, radius: 14),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bone(double.infinity, 14),
                const SizedBox(height: 8),
                _bone(double.infinity, 14),
                const SizedBox(height: 8),
                _bone(120, 14),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _bone(64, 22, radius: 11),
                    const SizedBox(width: 8),
                    _bone(64, 22, radius: 11),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Gradient transform for shimmer sweep
class _SlidingGradient extends GradientTransform {
  final double progress;
  const _SlidingGradient(this.progress);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * progress, 0, 0);
  }
}

// ─────────────────────────────────────────────
// DATA VIEW — real content cards
// ─────────────────────────────────────────────
class _DataView extends StatelessWidget {
  const _DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _articles.length,
      itemBuilder: (context, i) {
        return _ArticleCard(article: _articles[i], index: i);
      },
    );
  }
}

class _ArticleCard extends StatefulWidget {
  final Article article;
  final int index;
  const _ArticleCard({required this.article, required this.index});

  @override
  State<_ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<_ArticleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    // Stagger: each card starts slightly later
    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.article;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF131320),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
            boxShadow: [
              BoxShadow(
                color: a.accent.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(18)),
                child: Image.network(
                  a.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    color: a.accent.withOpacity(0.2),
                    child: Icon(Icons.image_outlined,
                        color: a.accent, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Text
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _Tag(label: a.category, color: a.accent),
                          const SizedBox(width: 8),
                          _Tag(label: a.time, color: Colors.white38),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color == Colors.white38 ? Colors.white54 : color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}