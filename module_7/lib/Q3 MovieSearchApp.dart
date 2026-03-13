import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ─────────────────────────────────────────────
//  ENTRY POINT
// ─────────────────────────────────────────────
// void main() => runApp(const MovieSearchApp());
//
// class MovieSearchApp extends StatelessWidget {
//   const MovieSearchApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CineSearch',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF080810),
//         fontFamily: 'Georgia',
//       ),
//       home: const MovieSearchScreen(),
//     );
//   }
// }

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class MovieSummary {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String? poster;

  MovieSummary({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.type,
    this.poster,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> j) => MovieSummary(
    imdbId: j['imdbID'] ?? '',
    title: j['Title'] ?? '',
    year: j['Year'] ?? '',
    type: j['Type'] ?? 'movie',
    poster: j['Poster'] == 'N/A' ? null : j['Poster'],
  );
}

class MovieDetail {
  final String imdbId;
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String? poster;
  final String imdbRating;
  final String imdbVotes;
  final String? metascore;
  final String type;
  final String? boxOffice;
  final String? awards;
  final List<_Rating> ratings;

  MovieDetail({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    this.poster,
    required this.imdbRating,
    required this.imdbVotes,
    this.metascore,
    required this.type,
    this.boxOffice,
    this.awards,
    required this.ratings,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> j) {
    final rawRatings = j['Ratings'] as List? ?? [];
    return MovieDetail(
      imdbId: j['imdbID'] ?? '',
      title: j['Title'] ?? '',
      year: j['Year'] ?? '',
      rated: j['Rated'] ?? 'N/A',
      released: j['Released'] ?? 'N/A',
      runtime: j['Runtime'] ?? 'N/A',
      genre: j['Genre'] ?? 'N/A',
      director: j['Director'] ?? 'N/A',
      writer: j['Writer'] ?? 'N/A',
      actors: j['Actors'] ?? 'N/A',
      plot: j['Plot'] ?? 'N/A',
      language: j['Language'] ?? 'N/A',
      country: j['Country'] ?? 'N/A',
      poster: j['Poster'] == 'N/A' ? null : j['Poster'],
      imdbRating: j['imdbRating'] ?? 'N/A',
      imdbVotes: j['imdbVotes'] ?? 'N/A',
      metascore: j['Metascore'] == 'N/A' ? null : j['Metascore'],
      type: j['Type'] ?? 'movie',
      boxOffice: j['BoxOffice'] == 'N/A' ? null : j['BoxOffice'],
      awards: j['Awards'] == 'N/A' ? null : j['Awards'],
      ratings: rawRatings.map((r) => _Rating.fromJson(r)).toList(),
    );
  }

  double get imdbRatingDouble =>
      double.tryParse(imdbRating) ?? 0.0;

  Color get ratingColor {
    final r = imdbRatingDouble;
    if (r >= 8.0) return const Color(0xFF4CAF50);
    if (r >= 6.5) return const Color(0xFFFFD166);
    return const Color(0xFFFF6B6B);
  }
}

class _Rating {
  final String source;
  final String value;
  _Rating({required this.source, required this.value});
  factory _Rating.fromJson(Map<String, dynamic> j) =>
      _Rating(source: j['Source'] ?? '', value: j['Value'] ?? '');
}

// ─────────────────────────────────────────────
//  API SERVICE  –  free key at omdbapi.com
// ─────────────────────────────────────────────
class OmdbService {
  static const String _apiKey = 'http://www.omdbapi.com/apikey.aspx?VERIFYKEY=557e00e7-da0d-4f12-9750-aa12fab32964';
  static const String _base = 'https://www.omdbapi.com/';

  static Future<List<MovieSummary>> search(String query,
      {String type = 'movie'}) async {
    final uri = Uri.parse(
        '$_base?s=${Uri.encodeComponent(query)}&type=$type&apikey=$_apiKey');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Network error');
    final data = jsonDecode(res.body);
    if (data['Response'] == 'False') {
      throw Exception(data['Error'] ?? 'No results found');
    }
    return (data['Search'] as List)
        .map((e) => MovieSummary.fromJson(e))
        .toList();
  }

  static Future<MovieDetail> detail(String imdbId) async {
    final uri =
    Uri.parse('$_base?i=$imdbId&plot=full&apikey=$_apiKey');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Network error');
    final data = jsonDecode(res.body);
    if (data['Response'] == 'False') {
      throw Exception(data['Error'] ?? 'Movie not found');
    }
    return MovieDetail.fromJson(data);
  }
}

// ─────────────────────────────────────────────
//  SEARCH SCREEN
// ─────────────────────────────────────────────
class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen>
    with SingleTickerProviderStateMixin {
  List<MovieSummary> _results = [];
  bool _loading = false;
  String? _error;
  bool _hasSearched = false;
  String _selectedType = 'movie';

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final AnimationController _shimmerCtrl;

  static const _types = [
    _TypeFilter('Movies', 'movie', Icons.movie_outlined),
    _TypeFilter('Series', 'series', Icons.live_tv_outlined),
    _TypeFilter('Episodes', 'episode', Icons.video_library_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    _shimmerCtrl.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final q = _ctrl.text.trim();
    if (q.isEmpty) return;
    _focusNode.unfocus();
    setState(() {
      _loading = true;
      _error = null;
      _hasSearched = true;
      _results = [];
    });
    try {
      final res = await OmdbService.search(q, type: _selectedType);
      setState(() {
        _results = res;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
      });
    }
  }

  void _openDetail(MovieSummary m) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => MovieDetailScreen(summary: m)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080810),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTypeFilter(),
            const SizedBox(height: 8),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ── Header ──
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        children: [
          // Logo mark
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE50914), Color(0xFFFF6B35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_movies_rounded,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CineSearch',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5)),
              Text('Powered by OMDb API',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 11,
                      letterSpacing: 0.3)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF14141E),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE50914).withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.search_rounded,
                color: Colors.white.withOpacity(0.35), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _ctrl,
                focusNode: _focusNode,
                onSubmitted: (_) => _search(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Georgia'),
                decoration: InputDecoration(
                  hintText: 'Search movies, shows...',
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.25),
                      fontSize: 15),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            if (_ctrl.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _ctrl.clear();
                  setState(() {
                    _results = [];
                    _hasSearched = false;
                    _error = null;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.close_rounded,
                      color: Colors.white.withOpacity(0.3), size: 18),
                ),
              ),
            GestureDetector(
              onTap: _search,
              child: Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE50914), Color(0xFFFF6B35)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Type Filter ──
  Widget _buildTypeFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        children: _types.map((t) {
          final active = t.value == _selectedType;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedType = t.value);
              if (_hasSearched && _ctrl.text.isNotEmpty) _search();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: active
                    ? const LinearGradient(
                    colors: [Color(0xFFE50914), Color(0xFFFF6B35)])
                    : null,
                color: active ? null : const Color(0xFF14141E),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: active
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.07),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(t.icon,
                      size: 13,
                      color: active
                          ? Colors.white
                          : Colors.white.withOpacity(0.35)),
                  const SizedBox(width: 6),
                  Text(t.label,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: active
                              ? Colors.white
                              : Colors.white.withOpacity(0.4))),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Body ──
  Widget _buildBody() {
    if (_loading) return _buildShimmer();
    if (_error != null) return _buildError();
    if (!_hasSearched) return _buildHint();
    if (_results.isEmpty) return _buildEmpty();
    return _buildGrid();
  }

  // ── Results Grid ──
  Widget _buildGrid() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: _results.length,
      itemBuilder: (_, i) => _buildMovieCard(_results[i]),
    );
  }

  Widget _buildMovieCard(MovieSummary m) {
    return GestureDetector(
      onTap: () => _openDetail(m),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF10101A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  m.poster != null
                      ? Image.network(m.poster!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _posterPlaceholder())
                      : _posterPlaceholder(),
                  // Type badge
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        m.type.toUpperCase(),
                        style: const TextStyle(
                            color: Color(0xFFFF6B35),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF10101A).withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 1.3)),
                  const SizedBox(height: 4),
                  Text(m.year,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.35),
                          fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Shimmer ──
  Widget _buildShimmer() {
    return AnimatedBuilder(
      animation: _shimmerCtrl,
      builder: (_, __) {
        final c = ColorTween(
            begin: const Color(0xFF14141E),
            end: const Color(0xFF22222E))
            .evaluate(_shimmerCtrl)!;
        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: List.generate(
              6,
                  (_) => Container(
                decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(18)),
              )),
        );
      },
    );
  }

  // ── Hint ──
  Widget _buildHint() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [
                const Color(0xFFE50914).withOpacity(0.15),
                Colors.transparent
              ]),
            ),
            child: const Icon(Icons.movie_filter_outlined,
                color: Color(0xFFE50914), size: 40),
          ),
          const SizedBox(height: 20),
          const Text('Discover Movies & Shows',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Type a title above to get started',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.35), fontSize: 14)),
        ],
      ),
    );
  }

  // ── Error ──
  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Color(0xFFE50914), size: 56),
            const SizedBox(height: 16),
            Text(_error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    height: 1.6)),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: _search,
              icon: const Icon(Icons.refresh_rounded,
                  color: Color(0xFFFF6B35)),
              label: const Text('Retry',
                  style: TextStyle(color: Color(0xFFFF6B35))),
            ),
          ],
        ),
      ),
    );
  }

  // ── Empty ──
  Widget _buildEmpty() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.search_off_rounded,
            color: Colors.white.withOpacity(0.2), size: 64),
        const SizedBox(height: 16),
        Text('No results for "${_ctrl.text}"',
            style: TextStyle(
                color: Colors.white.withOpacity(0.4), fontSize: 14)),
      ]),
    );
  }

  Widget _posterPlaceholder() => Container(
    color: const Color(0xFF14141E),
    child: const Center(
      child: Icon(Icons.image_not_supported_outlined,
          color: Colors.white12, size: 36),
    ),
  );
}

class _TypeFilter {
  const _TypeFilter(this.label, this.value, this.icon);
  final String label;
  final String value;
  final IconData icon;
}

// ─────────────────────────────────────────────
//  MOVIE DETAIL SCREEN
// ─────────────────────────────────────────────
class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.summary});
  final MovieSummary summary;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetail? _detail;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final d = await OmdbService.detail(widget.summary.imdbId);
      setState(() {
        _detail = d;
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
      backgroundColor: const Color(0xFF080810),
      body: _loading
          ? const Center(
          child: CircularProgressIndicator(
              color: Color(0xFFE50914), strokeWidth: 2))
          : _error != null
          ? _buildError()
          : _buildDetail(_detail!),
    );
  }

  Widget _buildError() => Center(
    child: Text(_error!,
        style: const TextStyle(color: Colors.white54, fontSize: 14)),
  );

  Widget _buildDetail(MovieDetail d) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── App Bar ──
        SliverAppBar(
          expandedHeight: 380,
          pinned: true,
          backgroundColor: const Color(0xFF080810),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                d.poster != null
                    ? Image.network(d.poster!, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                        color: Color(0xFF14141E)))
                    : const ColoredBox(color: Color(0xFF14141E)),
                // Scrim
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        const Color(0xFF080810),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 60,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: BackdropFilter(
                      filter:
                      ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: d.ratingColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color:
                              d.ratingColor.withOpacity(0.5)),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Colors.amber, size: 18),
                            const SizedBox(height: 2),
                            Text(d.imdbRating,
                                style: TextStyle(
                                    color: d.ratingColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                            Text('IMDb',
                                style: TextStyle(
                                    color: Colors.white
                                        .withOpacity(0.5),
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Detail Content ──
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + year
                Text(d.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        letterSpacing: -0.8,
                        fontFamily: 'Georgia')),
                const SizedBox(height: 8),

                // Meta chips row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _chip(d.year),
                    _chip(d.rated),
                    _chip(d.runtime),
                    ..._genreChips(d.genre),
                  ],
                ),

                const SizedBox(height: 20),

                // Awards banner
                if (d.awards != null)
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFD166).withOpacity(0.15),
                          const Color(0xFFFF6B35).withOpacity(0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: const Color(0xFFFFD166)
                              .withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_events_rounded,
                            color: Color(0xFFFFD166), size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(d.awards!,
                              style: const TextStyle(
                                  color: Color(0xFFFFD166),
                                  fontSize: 12,
                                  height: 1.4)),
                        ),
                      ],
                    ),
                  ),

                // Plot
                const _SectionLabel('Plot'),
                const SizedBox(height: 8),
                Text(d.plot,
                    style: const TextStyle(
                        color: Color(0xFFBBBBCC),
                        fontSize: 15,
                        height: 1.7,
                        fontFamily: 'Georgia')),

                const SizedBox(height: 24),

                // Ratings row
                if (d.ratings.isNotEmpty) ...[
                  const _SectionLabel('Ratings'),
                  const SizedBox(height: 12),
                  Row(
                    children: d.ratings
                        .take(3)
                        .map((r) => Expanded(child: _ratingCard(r)))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                ],

                // Cast & Crew
                const _SectionLabel('Cast & Crew'),
                const SizedBox(height: 14),
                _infoRow(Icons.person_outline_rounded,
                    'Director', d.director),
                _infoRow(Icons.edit_outlined, 'Writer',
                    d.writer.length > 60
                        ? '${d.writer.substring(0, 60)}…'
                        : d.writer),
                _infoRow(Icons.groups_outlined, 'Stars',
                    d.actors.length > 60
                        ? '${d.actors.substring(0, 60)}…'
                        : d.actors),

                const SizedBox(height: 24),

                // Details grid
                const _SectionLabel('Details'),
                const SizedBox(height: 14),
                _detailGrid(d),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Helpers ──
  Widget _chip(String label) => Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFF14141E),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white.withOpacity(0.08)),
    ),
    child: Text(label,
        style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
            fontWeight: FontWeight.w500)),
  );

  List<Widget> _genreChips(String genre) => genre
      .split(',')
      .take(3)
      .map((g) => _chip(g.trim()))
      .toList();

  Widget _ratingCard(_Rating r) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF14141E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Text(r.value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(
            r.source == 'Internet Movie Database'
                ? 'IMDb'
                : r.source == 'Rotten Tomatoes'
                ? 'Rotten\nTomatoes'
                : r.source,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFFE50914), size: 16),
            const SizedBox(width: 10),
            SizedBox(
              width: 72,
              child: Text(label,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.35),
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ),
            Expanded(
              child: Text(value,
                  style: const TextStyle(
                      color: Color(0xFFCCCCDD),
                      fontSize: 13,
                      height: 1.4)),
            ),
          ],
        ),
      );

  Widget _detailGrid(MovieDetail d) {
    final items = [
      ['Released', d.released],
      ['Language', d.language],
      ['Country', d.country],
      if (d.boxOffice != null) ['Box Office', d.boxOffice!],
      ['IMDb Votes', d.imdbVotes],
      if (d.metascore != null) ['Metascore', '${d.metascore}/100'],
    ];
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: items
          .map((item) => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF10101A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item[0],
                style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 10,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(item[1],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  SMALL REUSABLE WIDGETS
// ─────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFFE50914), Color(0xFFFF6B35)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(2),
            )),
        const SizedBox(width: 10),
        Text(text.toUpperCase(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5)),
      ],
    );
  }
}
