import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ── API KEY ──────────────────────────────────
// Get free key at https://newsapi.org
const _newsApiKey = '2d36f2ef88b34af7a1f811369b1f9003';

// ─────────────────────────────────────────────
//  MODEL
// ─────────────────────────────────────────────
class Article {
  final String title;
  final String? description, author, urlToImage, url, sourceName, content;
  final DateTime? publishedAt;

  Article({required this.title, this.description, this.author,
    this.urlToImage, this.url, this.sourceName, this.publishedAt, this.content});

  factory Article.fromJson(Map<String, dynamic> j) => Article(
    title: j['title'] ?? 'No title',
    description: j['description'],
    author: j['author'],
    urlToImage: j['urlToImage'],
    url: j['url'],
    sourceName: j['source']?['name'],
    publishedAt: j['publishedAt'] != null ? DateTime.tryParse(j['publishedAt']) : null,
    content: j['content'],
  );

  String get timeAgo {
    if (publishedAt == null) return '';
    final d = DateTime.now().difference(publishedAt!);
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${d.inDays}d ago';
  }
}

// ─────────────────────────────────────────────
//  SERVICE
// ─────────────────────────────────────────────
class NewsService {
  static Future<List<Article>> headlines({String cat = 'general'}) async {
    final uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$cat&pageSize=20&apiKey=$_newsApiKey');
    return _fetch(uri);
  }
  static Future<List<Article>> search(String q) async {
    final uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=${Uri.encodeComponent(q)}&sortBy=publishedAt&pageSize=20&apiKey=$_newsApiKey');
    return _fetch(uri);
  }
  static Future<List<Article>> _fetch(Uri uri) async {
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Network error ${res.statusCode}');
    final data = jsonDecode(res.body);
    if (data['Response'] == 'False') throw Exception(data['message'] ?? 'Error');
    return (data['articles'] as List)
        .map((e) => Article.fromJson(e))
        .where((a) => a.title != '[Removed]' && a.title.isNotEmpty)
        .toList();
  }
}

// ─────────────────────────────────────────────
//  CATEGORIES
// ─────────────────────────────────────────────
const _cats = [
  _Cat('Top', 'general', Icons.bolt_rounded),
  _Cat('Business', 'business', Icons.trending_up_rounded),
  _Cat('Tech', 'technology', Icons.memory_rounded),
  _Cat('Science', 'science', Icons.science_outlined),
  _Cat('Health', 'health', Icons.favorite_border_rounded),
  _Cat('Sports', 'sports', Icons.sports_rounded),
  _Cat('Entertainment', 'entertainment', Icons.movie_outlined),
];
class _Cat {
  const _Cat(this.label, this.value, this.icon);
  final String label, value; final IconData icon;
}

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override bool get wantKeepAlive => true;

  List<Article> _articles = [];
  bool _loading = false;
  String? _error;
  int _selCat = 0;
  bool _searching = false;
  final _ctrl = TextEditingController();
  late final AnimationController _shimCtrl;

  @override
  void initState() {
    super.initState();
    _shimCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
    _loadCat(0);
  }
  @override void dispose() { _ctrl.dispose(); _shimCtrl.dispose(); super.dispose(); }

  Future<void> _loadCat(int i) async {
    setState(() { _selCat = i; _loading = true; _error = null; _searching = false; _ctrl.clear(); });
    try {
      final a = await NewsService.headlines(cat: _cats[i].value);
      setState(() { _articles = a; _loading = false; });
    } catch (e) {
      setState(() { _error = e.toString().replaceFirst('Exception: ', ''); _loading = false; });
    }
  }

  Future<void> _doSearch(String q) async {
    if (q.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() { _loading = true; _error = null; _searching = true; });
    try {
      final a = await NewsService.search(q);
      setState(() { _articles = a; _loading = false; });
    } catch (e) {
      setState(() { _error = e.toString().replaceFirst('Exception: ', ''); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFF08080F),
      child: SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _header(),
        _searchBar(),
        _chips(),
        const SizedBox(height: 4),
        Expanded(child: _body()),
      ])),
    );
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
    child: Row(children: [
      Container(width: 36, height: 36,
          decoration: BoxDecoration(color: const Color(0xFFE8C56D).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8C56D).withOpacity(0.3))),
          child: const Icon(Icons.newspaper_rounded, color: Color(0xFFE8C56D), size: 18)),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('The Daily Briefing',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        Text('Top stories today', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
      ]),
    ]),
  );

  Widget _searchBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(color: const Color(0xFF14141E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.07))),
      child: Row(children: [
        const SizedBox(width: 14),
        Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.3), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _ctrl,
            onSubmitted: _doSearch,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(hintText: 'Search articles…',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
                border: InputBorder.none, isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 14)),
          ),
        ),
        if (_searching)
          GestureDetector(onTap: () => _loadCat(_selCat),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.3), size: 18)))
        else
          GestureDetector(
            onTap: () => _doSearch(_ctrl.text),
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFE8C56D), borderRadius: BorderRadius.circular(10)),
              child: const Text('Go', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w800)),
            ),
          ),
      ]),
    ),
  );

  Widget _chips() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
    child: SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _cats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = _cats[i];
          final active = i == _selCat && !_searching;
          return GestureDetector(
            onTap: () => _loadCat(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFE8C56D) : const Color(0xFF14141E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: active ? const Color(0xFFE8C56D) : Colors.white.withOpacity(0.07)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(cat.icon, size: 12, color: active ? Colors.black : Colors.white38),
                const SizedBox(width: 6),
                Text(cat.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                    color: active ? Colors.black : Colors.white70)),
              ]),
            ),
          );
        },
      ),
    ),
  );

  Widget _body() {
    if (_loading) return _shimmer();
    if (_error != null) return _errorView();
    if (_articles.isEmpty) return _empty();
    return _list();
  }

  Widget _list() => ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
    itemCount: _articles.length,
    itemBuilder: (_, i) => i == 0 ? _featured(_articles[0]) : _card(_articles[i]),
  );

  Widget _featured(Article a) => GestureDetector(
    onTap: () => _openDetail(a),
    child: Container(
      margin: const EdgeInsets.only(bottom: 14),
      height: 260,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), color: const Color(0xFF1A1A1F)),
      clipBehavior: Clip.antiAlias,
      child: Stack(fit: StackFit.expand, children: [
        if (a.urlToImage != null)
          Image.network(a.urlToImage!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _imgPlaceholder())
        else _imgPlaceholder(),
        Container(decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.9)], stops: const [0.3, 1.0]))),
        Positioned(left: 18, right: 18, bottom: 18, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (a.sourceName != null) Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(color: const Color(0xFFE8C56D), borderRadius: BorderRadius.circular(6)),
            child: Text(a.sourceName!, style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
          ),
          const SizedBox(height: 7),
          Text(a.title, maxLines: 3, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, height: 1.3)),
          const SizedBox(height: 6),
          Text(a.timeAgo, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        ])),
      ]),
    ),
  );

  Widget _card(Article a) => GestureDetector(
    onTap: () => _openDetail(a),
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF111115),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: SizedBox(width: 82, height: 82,
              child: a.urlToImage != null
                  ? Image.network(a.urlToImage!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _imgPlaceholder())
                  : _imgPlaceholder()),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (a.sourceName != null) Text(a.sourceName!.toUpperCase(),
              style: const TextStyle(color: Color(0xFFE8C56D), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1)),
          const SizedBox(height: 3),
          Text(a.title, maxLines: 3, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFFEEEEEE), fontSize: 13, fontWeight: FontWeight.w600, height: 1.35)),
          const SizedBox(height: 7),
          Row(children: [
            Text(a.timeAgo, style: const TextStyle(color: Colors.white30, fontSize: 10)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 10),
          ]),
        ])),
      ]),
    ),
  );

  Widget _shimmer() => AnimatedBuilder(
    animation: _shimCtrl,
    builder: (_, __) {
      final c = ColorTween(begin: const Color(0xFF1A1A1F), end: const Color(0xFF2A2A30)).evaluate(_shimCtrl)!;
      return ListView(padding: const EdgeInsets.fromLTRB(20, 14, 20, 32), children: [
        Container(height: 260, margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(22))),
        ...List.generate(5, (_) => Container(height: 94, margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(16)))),
      ]);
    },
  );

  Widget _errorView() => Center(child: Padding(
    padding: const EdgeInsets.all(32),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.wifi_off_rounded, color: Colors.white24, size: 56),
      const SizedBox(height: 16),
      Text(_error!, textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white38, fontSize: 13, height: 1.6)),
      const SizedBox(height: 20),
      TextButton.icon(onPressed: () => _loadCat(_selCat),
          icon: const Icon(Icons.refresh_rounded, color: Color(0xFFE8C56D)),
          label: const Text('Retry', style: TextStyle(color: Color(0xFFE8C56D)))),
    ]),
  ));

  Widget _empty() => const Center(child: Text('No articles found',
      style: TextStyle(color: Colors.white38, fontSize: 14)));

  Widget _imgPlaceholder() => Container(color: const Color(0xFF1E1E24),
      child: const Center(child: Icon(Icons.image_outlined, color: Colors.white12, size: 24)));

  void _openDetail(Article a) => Navigator.push(context,
      MaterialPageRoute(builder: (_) => _NewsDetailScreen(article: a)));
}

// ─────────────────────────────────────────────
//  NEWS DETAIL SCREEN
// ─────────────────────────────────────────────
class _NewsDetailScreen extends StatelessWidget {
  const _NewsDetailScreen({required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final a = article;
    return Scaffold(
      backgroundColor: const Color(0xFF08080F),
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          expandedHeight: 260,
          pinned: true,
          backgroundColor: const Color(0xFF08080F),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1))),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20)),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: a.urlToImage != null
                ? Stack(fit: StackFit.expand, children: [
              Image.network(a.urlToImage!, fit: BoxFit.cover),
              Container(decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, const Color(0xFF08080F)], stops: const [0.5, 1.0]))),
            ]) : const ColoredBox(color: Color(0xFF1A1A1F)),
          ),
        ),
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 48),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              if (a.sourceName != null) Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFE8C56D).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE8C56D).withOpacity(0.3))),
                child: Text(a.sourceName!, style: const TextStyle(color: Color(0xFFE8C56D), fontSize: 10, fontWeight: FontWeight.w700)),
              ),
              const Spacer(),
              Text(a.timeAgo, style: const TextStyle(color: Colors.white30, fontSize: 11)),
            ]),
            const SizedBox(height: 14),
            Text(a.title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, height: 1.3, letterSpacing: -0.5)),
            if (a.author != null) ...[
              const SizedBox(height: 12),
              Row(children: [
                Container(width: 26, height: 26, decoration: BoxDecoration(shape: BoxShape.circle,
                    color: const Color(0xFFE8C56D).withOpacity(0.15)),
                    child: const Icon(Icons.person_rounded, color: Color(0xFFE8C56D), size: 14)),
                const SizedBox(width: 8),
                Expanded(child: Text(a.author!, style: const TextStyle(color: Colors.white54, fontSize: 12))),
              ]),
            ],
            const SizedBox(height: 20),
            Container(height: 1, color: Colors.white.withOpacity(0.07)),
            const SizedBox(height: 20),
            if (a.description != null) Text(a.description!,
                style: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 15, height: 1.7)),
            if (a.content != null) ...[
              const SizedBox(height: 14),
              Text(a.content!.replaceAll(RegExp(r'\[\d+ chars\]'), '…'),
                  style: const TextStyle(color: Color(0xFF999999), fontSize: 14, height: 1.7)),
            ],
          ]),
        )),
      ]),
    );
  }
}
