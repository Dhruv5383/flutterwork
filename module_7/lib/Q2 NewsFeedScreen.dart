// final code Q2
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ─────────────────────────────────────────────
//  ENTRY POINT
// ─────────────────────────────────────────────
// void main() => runApp(const NewsFeedApp());
//
// class NewsFeedApp extends StatelessWidget {
//   const NewsFeedApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'News Feed',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF0A0A0C),
//         colorScheme: const ColorScheme.dark(
//           primary: Color(0xFFE8C56D),
//           surface: Color(0xFF111115),
//         ),
//         fontFamily: 'Georgia',
//       ),
//       home: const NewsFeedScreen(),
//     );
//   }
// }

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class Article {
  final String title;
  final String? description;
  final String? author;
  final String? urlToImage;
  final String? url;
  final String? sourceName;
  final DateTime? publishedAt;
  final String? content;

  Article({
    required this.title,
    this.description,
    this.author,
    this.urlToImage,
    this.url,
    this.sourceName,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No title',
      description: json['description'],
      author: json['author'],
      urlToImage: json['urlToImage'],
      url: json['url'],
      sourceName: json['source']?['name'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }

  String get timeAgo {
    if (publishedAt == null) return '';
    final diff = DateTime.now().difference(publishedAt!);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

// ─────────────────────────────────────────────
//  API SERVICE
//  Get a free key at https://newsapi.org
// ─────────────────────────────────────────────
class NewsService {
  static const String _apiKey = '2d36f2ef88b34af7a1f811369b1f9003';
  static const String _base = 'https://newsapi.org/v2';

  static Future<List<Article>> fetchTopHeadlines({String category = 'general'}) async {
    final uri = Uri.parse(
        '$_base/top-headlines?country=us&category=$category&pageSize=20&apiKey=$_apiKey');
    return _fetch(uri);
  }

  static Future<List<Article>> searchArticles(String query) async {
    final uri = Uri.parse(
        '$_base/everything?q=${Uri.encodeComponent(query)}&sortBy=publishedAt&pageSize=20&apiKey=$_apiKey');
    return _fetch(uri);
  }

  static Future<List<Article>> _fetch(Uri uri) async {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .where((a) => a.title != '[Removed]' && a.title.isNotEmpty)
          .toList();
      return articles;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key. Get one free at newspaper.org');
    } else {
      throw Exception('Failed to load news (${response.statusCode})');
    }
  }
}

// ─────────────────────────────────────────────
//  CATEGORIES
// ─────────────────────────────────────────────
const _categories = [
  _Category('Top', 'general', Icons.bolt_rounded),
  _Category('Business', 'business', Icons.trending_up_rounded),
  _Category('Tech', 'technology', Icons.memory_rounded),
  _Category('Science', 'science', Icons.science_outlined),
  _Category('Health', 'health', Icons.favorite_border_rounded),
  _Category('Sports', 'sports', Icons.sports_rounded),
  _Category('Entertainment', 'entertainment', Icons.movie_outlined),
];

class _Category {
  const _Category(this.label, this.value, this.icon);
  final String label;
  final String value;
  final IconData icon;
}

// ─────────────────────────────────────────────
//  MAIN SCREEN
// ─────────────────────────────────────────────
class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen>
    with SingleTickerProviderStateMixin {
  List<Article> _articles = [];
  bool _loading = false;
  String? _error;
  int _selectedCategory = 0;
  bool _searching = false;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _loadCategory(0);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _loadCategory(int index) async {
    setState(() {
      _selectedCategory = index;
      _loading = true;
      _error = null;
      _searching = false;
      _searchController.clear();
    });
    try {
      final articles = await NewsService.fetchTopHeadlines(
          category: _categories[index].value);
      setState(() {
        _articles = articles;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  Future<void> _doSearch(String query) async {
    if (query.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _loading = true;
      _error = null;
      _searching = true;
    });
    try {
      final articles = await NewsService.searchArticles(query.trim());
      setState(() {
        _articles = articles;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryChips(),
            const SizedBox(height: 4),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ── Header ──
  Widget _buildHeader() {
    final now = DateTime.now();
    final months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final date = '${months[now.month - 1]} ${now.day}, ${now.year}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date,
                    style: const TextStyle(
                        color: Color(0xFFE8C56D),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        fontFamily: 'Georgia')),
                const SizedBox(height: 4),
                const Text('The Daily\nBriefing',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                        letterSpacing: -1,
                        fontFamily: 'Georgia')),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8C56D).withOpacity(0.15),
              border: Border.all(
                  color: const Color(0xFFE8C56D).withOpacity(0.3)),
            ),
            child: const Icon(Icons.newspaper_rounded,
                color: Color(0xFFE8C56D), size: 20),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.07)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search_rounded,
                color: Colors.white38, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Georgia'),
                onSubmitted: _doSearch,
                decoration: const InputDecoration(
                  hintText: 'Search articles...',
                  hintStyle:
                  TextStyle(color: Colors.white30, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            if (_searching)
              GestureDetector(
                onTap: () => _loadCategory(_selectedCategory),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Icon(Icons.close_rounded,
                      color: Colors.white38, size: 18),
                ),
              )
            else
              GestureDetector(
                onTap: () => _doSearch(_searchController.text),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8C56D),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Search',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── Category Chips ──
  Widget _buildCategoryChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final cat = _categories[i];
          final isSelected = i == _selectedCategory && !_searching;
          return GestureDetector(
            onTap: () => _loadCategory(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE8C56D)
                    : const Color(0xFF1A1A1F),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFE8C56D)
                      : Colors.white.withOpacity(0.07),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(cat.icon,
                      size: 13,
                      color: isSelected
                          ? Colors.black
                          : Colors.white38),
                  const SizedBox(width: 6),
                  Text(cat.label,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                          isSelected ? Colors.black : Colors.white54)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Body ──
  Widget _buildBody() {
    if (_loading) return _buildShimmer();
    if (_error != null) return _buildError();
    if (_articles.isEmpty) return _buildEmpty();
    return _buildArticleList();
  }

  // ── Article List ──
  Widget _buildArticleList() {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      itemCount: _articles.length,
      itemBuilder: (_, i) {
        if (i == 0) return _buildFeaturedCard(_articles[0]);
        return _buildArticleCard(_articles[i], i);
      },
    );
  }

  // ── Featured Card (first article) ──
  Widget _buildFeaturedCard(Article a) {
    return GestureDetector(
      onTap: () => _openDetail(a),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF1A1A1F),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            if (a.urlToImage != null)
              Image.network(
                a.urlToImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    _imagePlaceholder(large: true),
              )
            else
              _imagePlaceholder(large: true),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
            // Text content
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (a.sourceName != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8C56D),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(a.sourceName!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5)),
                    ),
                  const SizedBox(height: 8),
                  Text(a.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.3)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded,
                          color: Colors.white38, size: 12),
                      const SizedBox(width: 4),
                      Text(a.timeAgo,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 12)),
                      if (a.author != null) ...[
                        const SizedBox(width: 12),
                        const Icon(Icons.person_outline_rounded,
                            color: Colors.white38, size: 12),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(a.author!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12)),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Regular Article Card ──
  Widget _buildArticleCard(Article a, int index) {
    return GestureDetector(
      onTap: () => _openDetail(a),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF111115),
          borderRadius: BorderRadius.circular(18),
          border:
          Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 88,
                height: 88,
                child: a.urlToImage != null
                    ? Image.network(a.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _imagePlaceholder())
                    : _imagePlaceholder(),
              ),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (a.sourceName != null)
                    Text(a.sourceName!.toUpperCase(),
                        style: const TextStyle(
                            color: Color(0xFFE8C56D),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text(a.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color(0xFFEEEEEE),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.35)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(a.timeAgo,
                          style: const TextStyle(
                              color: Colors.white30,
                              fontSize: 11)),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white70, size: 11),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Shimmer Loading ──
  Widget _buildShimmer() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (_, __) {
        final shimmerColor = ColorTween(
          begin: const Color(0xFF1A1A1F),
          end: const Color(0xFF2A2A30),
        ).evaluate(_shimmerController)!;

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            // Featured placeholder
            Container(
              height: 300,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: shimmerColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            ...List.generate(
              5,
                  (_) => Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: shimmerColor,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Error State ──
  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded,
                color: Colors.white24, size: 64),
            const SizedBox(height: 20),
            Text(_error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                    height: 1.6)),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => _loadCategory(_selectedCategory),
              icon: const Icon(Icons.refresh_rounded,
                  color: Color(0xFFE8C56D)),
              label: const Text('Try Again',
                  style: TextStyle(color: Color(0xFFE8C56D))),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty State ──
  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.article_outlined,
              color: Colors.white24, size: 64),
          SizedBox(height: 16),
          Text('No articles found',
              style: TextStyle(color: Colors.white38, fontSize: 15)),
        ],
      ),
    );
  }

  // ── Image Placeholder ──
  Widget _imagePlaceholder({bool large = false}) {
    return Container(
      color: const Color(0xFF1E1E24),
      child: Center(
        child: Icon(Icons.image_outlined,
            color: Colors.white12, size: large ? 48 : 24),
      ),
    );
  }

  // ── Open Detail ──
  void _openDetail(Article a) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: a)),
    );
  }
}

// ─────────────────────────────────────────────
//  ARTICLE DETAIL SCREEN
// ─────────────────────────────────────────────
class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF0A0A0C),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                  border:
                  Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: const Icon(Icons.arrow_back_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: article.urlToImage != null
                  ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(article.urlToImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const ColoredBox(
                          color: Color(0xFF1A1A1F))),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF0A0A0C),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              )
                  : const ColoredBox(color: Color(0xFF1A1A1F)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 4, 22, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source + time
                  Row(
                    children: [
                      if (article.sourceName != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFFE8C56D).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: const Color(0xFFE8C56D)
                                    .withOpacity(0.3)),
                          ),
                          child: Text(article.sourceName!,
                              style: const TextStyle(
                                  color: Color(0xFFE8C56D),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5)),
                        ),
                      const Spacer(),
                      Text(article.timeAgo,
                          style: const TextStyle(
                              color: Colors.white30,
                              fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Title
                  Text(article.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          letterSpacing: -0.5,
                          fontFamily: 'Georgia')),
                  const SizedBox(height: 12),
                  // Author
                  if (article.author != null)
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE8C56D).withOpacity(0.2),
                          ),
                          child: const Icon(Icons.person_rounded,
                              color: Color(0xFFE8C56D), size: 16),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(article.author!,
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 13)),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  // Divider
                  Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.07)),
                  const SizedBox(height: 24),
                  // Description
                  if (article.description != null)
                    Text(article.description!,
                        style: const TextStyle(
                            color: Color(0xFFCCCCCC),
                            fontSize: 16,
                            height: 1.7,
                            fontFamily: 'Georgia')),
                  const SizedBox(height: 16),
                  // Content (truncated by API)
                  if (article.content != null) ...[
                    Text(
                      article.content!
                          .replaceAll(RegExp(r'\[\d+ chars\]'), '…'),
                      style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 15,
                          height: 1.7,
                          fontFamily: 'Georgia'),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8C56D).withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color:
                            const Color(0xFFE8C56D).withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              color: Color(0xFFE8C56D), size: 16),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Full article available at ${article.sourceName ?? "the source"}',
                              style: const TextStyle(
                                  color: Color(0xFFE8C56D),
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
