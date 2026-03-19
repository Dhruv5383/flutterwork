
import 'dart:math';
import 'package:flutter/material.dart';
//  three in one code
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Animations',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0A0A12),
//       ),
//       home: const MainNav(),
//     );
//   }
// }

// ════════════════════════════════════════════════
//  BOTTOM-NAV SHELL
// ════════════════════════════════════════════════
class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _tab = 0;

  static const _screens = [
    AnimatedButtonScreen(),
    GalleryScreen(),
    FetchScreen(),
  ];

  static const _labels = ['Button', 'Hero', 'Loader'];
  static const _icons = [
    Icons.touch_app_rounded,
    Icons.photo_library_rounded,
    Icons.cloud_download_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      body: IndexedStack(index: _tab, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF11111C),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (i) {
                final active = i == _tab;
                return GestureDetector(
                  onTap: () => setState(() => _tab = i),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFF7C6FCD).withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(_icons[i],
                            size: 20,
                            color: active
                                ? const Color(0xFF7C6FCD)
                                : Colors.white30),
                        if (active) ...[
                          const SizedBox(width: 6),
                          Text(
                            _labels[i],
                            style: const TextStyle(
                              color: Color(0xFF7C6FCD),
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  TAB 1 — ANIMATED BUTTON (implicit animations)
// ════════════════════════════════════════════════
class AnimatedButtonScreen extends StatelessWidget {
  const AnimatedButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: _appBar('ANIMATED BUTTONS'),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SectionLabel('AnimatedContainer + AnimatedDefaultTextStyle'),
              SizedBox(height: 32),
              PressButton(
                label: 'TAP ME',
                defaultColor: Color(0xFF1A1A3E),
                pressedColor: Color(0xFF6C63FF),
                defaultWidth: 160,
                pressedWidth: 210,
                borderRadius: 16,
              ),
              SizedBox(height: 28),
              PressButton(
                label: '🚀  LAUNCH',
                defaultColor: Color(0xFF0D2B1E),
                pressedColor: Color(0xFF52B788),
                defaultWidth: 150,
                pressedWidth: 200,
                borderRadius: 50,
              ),
              SizedBox(height: 28),
              PressButton(
                label: '♥  LIKE',
                defaultColor: Color(0xFF2B0D0D),
                pressedColor: Color(0xFFE63946),
                defaultWidth: 140,
                pressedWidth: 190,
                borderRadius: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PressButton extends StatefulWidget {
  final String label;
  final Color defaultColor, pressedColor;
  final double defaultWidth, pressedWidth, borderRadius;

  const PressButton({
    super.key,
    required this.label,
    required this.defaultColor,
    required this.pressedColor,
    required this.defaultWidth,
    required this.pressedWidth,
    required this.borderRadius,
  });

  @override
  State<PressButton> createState() => _PressButtonState();
}

class _PressButtonState extends State<PressButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        width: _pressed ? widget.pressedWidth : widget.defaultWidth,
        height: _pressed ? 58 : 50,
        decoration: BoxDecoration(
          color: _pressed ? widget.pressedColor : widget.defaultColor,
          borderRadius: BorderRadius.circular(
              _pressed ? widget.borderRadius * 1.4 : widget.borderRadius),
          boxShadow: _pressed
              ? [
            BoxShadow(
              color: widget.pressedColor.withOpacity(0.5),
              blurRadius: 28,
              spreadRadius: 4,
            )
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(
            color: _pressed
                ? widget.pressedColor
                : widget.pressedColor.withOpacity(0.25),
            width: _pressed ? 2 : 1,
          ),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: TextStyle(
              color: _pressed ? Colors.white : Colors.white54,
              fontSize: _pressed ? 16 : 14,
              fontWeight: _pressed ? FontWeight.bold : FontWeight.w500,
              letterSpacing: _pressed ? 3 : 2,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  TAB 2 — HERO ANIMATION
// ════════════════════════════════════════════════
class PhotoItem {
  final String tag, imageUrl, title, subtitle;
  final Color accent;
  const PhotoItem({
    required this.tag,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
}

const _photos = [
  PhotoItem(
    tag: 'hero_mountain',
    imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    title: 'Alpine Peaks',
    subtitle: 'Swiss Alps · 4,478 m',
    accent: Color(0xFF5C8FD6),
  ),
  PhotoItem(
    tag: 'hero_forest',
    imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=800',
    title: 'Ancient Forest',
    subtitle: 'Pacific Northwest · Oregon',
    accent: Color(0xFF4CAF82),
  ),
  PhotoItem(
    tag: 'hero_ocean',
    imageUrl: 'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=800',
    title: 'Open Ocean',
    subtitle: 'Maldives · Indian Ocean',
    accent: Color(0xFF26C6DA),
  ),
  PhotoItem(
    tag: 'hero_desert',
    imageUrl: 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800',
    title: 'Sahara Dunes',
    subtitle: 'Morocco · Erg Chebbi',
    accent: Color(0xFFFFB74D),
  ),
];

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: _appBar('HERO GALLERY'),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: _photos.length,
        itemBuilder: (ctx, i) => _GalleryCard(photo: _photos[i]),
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final PhotoItem photo;
  const _GalleryCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 480),
          reverseTransitionDuration: const Duration(milliseconds: 380),
          pageBuilder: (_, __, ___) => PhotoDetailScreen(photo: photo),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeIn),
            child: child,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: photo.accent.withOpacity(0.22),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: photo.tag,
                child: Image.network(photo.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, p) => p == null
                        ? child
                        : _imgPlaceholder(photo.accent)),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.72),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(photo.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(photo.subtitle,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 13)),
                  ],
                ),
              ),
              Positioned(
                right: 14,
                bottom: 14,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white, size: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoDetailScreen extends StatelessWidget {
  final PhotoItem photo;
  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: photo.tag,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.52,
              child: Image.network(photo.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, p) =>
                  p == null ? child : _imgPlaceholder(photo.accent)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _accentTag(photo.subtitle.toUpperCase(), photo.accent),
                  const SizedBox(height: 14),
                  Text(photo.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          height: 1.1)),
                  const SizedBox(height: 14),
                  Text(
                    'A breathtaking destination that draws thousands of visitors '
                        'every year. Its stunning landscapes and serene atmosphere '
                        'make it one of the most photographed spots on Earth.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 15,
                        height: 1.7),
                  ),
                  const SizedBox(height: 24),
                  Row(children: [
                    _statChip(Icons.photo_camera_outlined, '2.4k Photos',
                        photo.accent),
                    const SizedBox(width: 10),
                    _statChip(Icons.favorite_border_rounded, '18.9k Likes',
                        photo.accent),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  TAB 3 — LOADING / FETCH ANIMATION
// ════════════════════════════════════════════════
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

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});
  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  bool _loading = true;

  Future<void> _reload() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) setState(() => _loading = false);
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
        title: const Text('DISCOVER',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 4)),
        centerTitle: true,
        actions: [
          if (!_loading)
            IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white38),
              onPressed: _reload,
            ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _loading
            ? const _LoadingView(key: ValueKey('loading'))
            : const _ArticleListView(key: ValueKey('data')),
      ),
    );
  }
}

// ── Skeleton + orbital spinner ────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const OrbitalLoader(),
          const SizedBox(height: 12),
          Text('Fetching latest stories…',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 13,
                  letterSpacing: 1)),
          const SizedBox(height: 36),
          ...List.generate(4, (_) => const _SkeletonCard()),
        ],
      ),
    );
  }
}

class OrbitalLoader extends StatefulWidget {
  const OrbitalLoader({super.key});
  @override
  State<OrbitalLoader> createState() => _OrbitalLoaderState();
}

class _OrbitalLoaderState extends State<OrbitalLoader>
    with TickerProviderStateMixin {
  late final List<AnimationController> _ctrs;
  late final List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    final cfgs = [
      (ms: 1100, rev: false),
      (ms: 1700, rev: true),
      (ms: 2300, rev: false),
    ];
    _ctrs = cfgs
        .map((c) => AnimationController(
      vsync: this,
      duration: Duration(milliseconds: c.ms),
    )..repeat(reverse: c.rev))
        .toList();
    _anims = _ctrs
        .map((c) => Tween(begin: 0.0, end: 2 * pi).animate(c))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _ctrs) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFF7C6FCD), Color(0xFF26C6DA), Color(0xFFFFB74D)];
    const sizes = [84.0, 58.0, 34.0];
    return SizedBox(
      width: 92,
      height: 92,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // glowing core
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.6),
                    blurRadius: 14,
                    spreadRadius: 2),
              ],
            ),
          ),
          ...List.generate(
            3,
                (i) => AnimatedBuilder(
              animation: _anims[i],
              builder: (_, __) => Transform.rotate(
                angle: _anims[i].value,
                child: SizedBox(
                  width: sizes[i],
                  height: sizes[i],
                  child: CustomPaint(
                      painter: _RingPainter(color: colors[i])),
                ),
              ),
            ),
          ),
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
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    // faint ring
    canvas.drawCircle(
        c,
        r,
        Paint()
          ..color = color.withOpacity(0.12)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    // glowing arc
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r),
      -pi / 2,
      pi / 2,
      false,
      Paint()
        ..shader = SweepGradient(
          colors: [color.withOpacity(0), color],
        ).createShader(Rect.fromCircle(center: c, radius: r))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    // leading dot
    canvas.drawCircle(
      Offset(c.dx + r * cos(-pi / 2), c.dy + r * sin(-pi / 2)),
      3,
      Paint()
        ..color = color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
  }

  @override
  bool shouldRepaint(_RingPainter o) => o.color != color;
}

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
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat();
    _shimmer = Tween(begin: -1.5, end: 2.5)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _bone(double w, double h, {double r = 8}) => AnimatedBuilder(
    animation: _shimmer,
    builder: (_, __) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r),
        gradient: LinearGradient(
          colors: const [
            Color(0xFF1E1E2E),
            Color(0xFF2A2A3E),
            Color(0xFF1E1E2E),
          ],
          stops: const [0, .5, 1],
          transform: _SlideGradient(_shimmer.value),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF131320),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          _bone(88, 88, r: 14),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bone(double.infinity, 13),
                const SizedBox(height: 8),
                _bone(double.infinity, 13),
                const SizedBox(height: 8),
                _bone(110, 13),
                const SizedBox(height: 14),
                Row(children: [
                  _bone(62, 22, r: 11),
                  const SizedBox(width: 8),
                  _bone(62, 22, r: 11),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideGradient extends GradientTransform {
  final double v;
  const _SlideGradient(this.v);
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * v, 0, 0);
}

// ── Article cards (staggered entrance) ────────
class _ArticleListView extends StatelessWidget {
  const _ArticleListView({super.key});
  @override
  Widget build(BuildContext context) => ListView.builder(
    padding: const EdgeInsets.all(20),
    itemCount: _articles.length,
    itemBuilder: (_, i) => _ArticleCard(article: _articles[i], index: i),
  );
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
        vsync: this, duration: const Duration(milliseconds: 480));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, .1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: 80 * widget.index),
            () { if (mounted) _ctrl.forward(); });
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
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF131320),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.06)),
            boxShadow: [
              BoxShadow(
                  color: a.accent.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6)),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(18)),
                child: Image.network(a.imageUrl,
                    width: 98,
                    height: 98,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _imgPlaceholder(a.accent, size: 98)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.4)),
                      const SizedBox(height: 10),
                      Row(children: [
                        _accentTag(a.category, a.accent),
                        const SizedBox(width: 8),
                        _accentTag(a.time, Colors.white30),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  SHARED HELPERS
// ════════════════════════════════════════════════
AppBar _appBar(String title) => AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  title: Text(title,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 18,
          letterSpacing: 3)),
);

Widget _imgPlaceholder(Color accent, {double size = double.infinity}) =>
    Container(
      width: size == double.infinity ? null : size,
      height: size == double.infinity ? null : size,
      color: accent.withOpacity(0.15),
      child: Icon(Icons.image_outlined, color: accent, size: 28),
    );

Widget _accentTag(String text, Color color) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  decoration: BoxDecoration(
    color: color.withOpacity(0.12),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: color.withOpacity(0.3)),
  ),
  child: Text(text,
      style: TextStyle(
          color: color == Colors.white30 ? Colors.white54 : color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: .5)),
);

Widget _statChip(IconData icon, String label, Color accent) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.06),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
  ),
  child: Row(children: [
    Icon(icon, color: accent, size: 15),
    const SizedBox(width: 7),
    Text(label,
        style: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
  ]),
);

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.white.withOpacity(0.25),
        fontSize: 11,
        letterSpacing: 1.2),
  );
}