import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ── API KEY ──────────────────────────────────
// Get free key at https://www.omdbapi.com/apikey.aspx
const _omdbApiKey = 'http://www.omdbapi.com/apikey.aspx?VERIFYKEY=557e00e7-da0d-4f12-9750-aa12fab32964';

// ─────────────────────────────────────────────
//  MODELS
// ─────────────────────────────────────────────
class MovieSummary {
  final String imdbId, title, year, type;
  final String? poster;
  MovieSummary({required this.imdbId, required this.title, required this.year, required this.type, this.poster});
  factory MovieSummary.fromJson(Map<String, dynamic> j) => MovieSummary(
    imdbId: j['imdbID'] ?? '', title: j['Title'] ?? '',
    year: j['Year'] ?? '', type: j['Type'] ?? 'movie',
    poster: j['Poster'] == 'N/A' ? null : j['Poster'],
  );
}

class MovieDetail {
  final String imdbId, title, year, rated, released, runtime, genre;
  final String director, writer, actors, plot, language, country;
  final String imdbRating, imdbVotes, type;
  final String? poster, metascore, boxOffice, awards;
  final List<_Rating> ratings;

  MovieDetail({required this.imdbId, required this.title, required this.year,
    required this.rated, required this.released, required this.runtime,
    required this.genre, required this.director, required this.writer,
    required this.actors, required this.plot, required this.language,
    required this.country, required this.imdbRating, required this.imdbVotes,
    required this.type, this.poster, this.metascore, this.boxOffice,
    this.awards, required this.ratings});

  factory MovieDetail.fromJson(Map<String, dynamic> j) => MovieDetail(
    imdbId: j['imdbID'] ?? '', title: j['Title'] ?? '',
    year: j['Year'] ?? '', rated: j['Rated'] ?? 'N/A',
    released: j['Released'] ?? 'N/A', runtime: j['Runtime'] ?? 'N/A',
    genre: j['Genre'] ?? 'N/A', director: j['Director'] ?? 'N/A',
    writer: j['Writer'] ?? 'N/A', actors: j['Actors'] ?? 'N/A',
    plot: j['Plot'] ?? 'N/A', language: j['Language'] ?? 'N/A',
    country: j['Country'] ?? 'N/A',
    imdbRating: j['imdbRating'] ?? 'N/A', imdbVotes: j['imdbVotes'] ?? 'N/A',
    type: j['Type'] ?? 'movie',
    poster: j['Poster'] == 'N/A' ? null : j['Poster'],
    metascore: j['Metascore'] == 'N/A' ? null : j['Metascore'],
    boxOffice: j['BoxOffice'] == 'N/A' ? null : j['BoxOffice'],
    awards: j['Awards'] == 'N/A' ? null : j['Awards'],
    ratings: (j['Ratings'] as List? ?? []).map((r) => _Rating.fromJson(r)).toList(),
  );

  double get ratingVal => double.tryParse(imdbRating) ?? 0.0;
  Color get ratingColor => ratingVal >= 8.0 ? const Color(0xFF4CAF50) : ratingVal >= 6.5 ? const Color(0xFFFFD166) : const Color(0xFFFF6B6B);
}

class _Rating {
  final String source, value;
  _Rating({required this.source, required this.value});
  factory _Rating.fromJson(Map<String, dynamic> j) => _Rating(source: j['Source'] ?? '', value: j['Value'] ?? '');
}

// ─────────────────────────────────────────────
//  SERVICE
// ─────────────────────────────────────────────
class OmdbService {
  static Future<List<MovieSummary>> search(String q, {String type = 'movie'}) async {
    final uri = Uri.parse('https://www.omdbapi.com/?s=${Uri.encodeComponent(q)}&type=$type&apikey=$_omdbApiKey');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Network error');
    final d = jsonDecode(res.body);
    if (d['Response'] == 'False') throw Exception(d['Error'] ?? 'No results found');
    return (d['Search'] as List).map((e) => MovieSummary.fromJson(e)).toList();
  }

  static Future<MovieDetail> detail(String imdbId) async {
    final uri = Uri.parse('https://www.omdbapi.com/?i=$imdbId&plot=full&apikey=$_omdbApiKey');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Network error');
    final d = jsonDecode(res.body);
    if (d['Response'] == 'False') throw Exception(d['Error'] ?? 'Movie not found');
    return MovieDetail.fromJson(d);
  }
}

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});
  @override State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override bool get wantKeepAlive => true;

  List<MovieSummary> _results = [];
  bool _loading = false;
  String? _error;
  bool _searched = false;
  String _type = 'movie';
  final _ctrl = TextEditingController();
  final _focus = FocusNode();
  late final AnimationController _shimCtrl;

  static const _types = [
    _TypeF('Movies', 'movie', Icons.movie_outlined),
    _TypeF('Series', 'series', Icons.live_tv_outlined),
    _TypeF('Episodes', 'episode', Icons.video_library_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _shimCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }
  @override void dispose() { _ctrl.dispose(); _focus.dispose(); _shimCtrl.dispose(); super.dispose(); }

  Future<void> _search() async {
    final q = _ctrl.text.trim();
    if (q.isEmpty) return;
    _focus.unfocus();
    setState(() { _loading = true; _error = null; _searched = true; _results = []; });
    try {
      final r = await OmdbService.search(q, type: _type);
      setState(() { _results = r; _loading = false; });
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
        _typeFilter(),
        const SizedBox(height: 8),
        Expanded(child: _body()),
      ])),
    );
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(22, 20, 22, 14),
    child: Row(children: [
      Container(width: 40, height: 40,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFE50914), Color(0xFFFF6B35)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.local_movies_rounded, color: Colors.white, size: 20)),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('CineSearch', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
        Text('Powered by OMDb', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
      ]),
    ]),
  );

  Widget _searchBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14141E),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [BoxShadow(color: const Color(0xFFE50914).withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(children: [
        const SizedBox(width: 14),
        Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.3), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _ctrl,
            focusNode: _focus,
            onSubmitted: (_) => _search(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(hintText: 'Search movies, shows…',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
                border: InputBorder.none, isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 16)),
          ),
        ),
        if (_ctrl.text.isNotEmpty)
          GestureDetector(
            onTap: () { _ctrl.clear(); setState(() { _results = []; _searched = false; _error = null; }); },
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.3), size: 16)),
          ),
        GestureDetector(
          onTap: _search,
          child: Container(
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFE50914), Color(0xFFFF6B35)]),
                borderRadius: BorderRadius.circular(12)),
            child: const Text('Search', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ),
      ]),
    ),
  );

  Widget _typeFilter() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
    child: Row(children: _types.map((t) {
      final active = t.value == _type;
      return GestureDetector(
        onTap: () { setState(() => _type = t.value); if (_searched && _ctrl.text.isNotEmpty) _search(); },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: active ? const LinearGradient(colors: [Color(0xFFE50914), Color(0xFFFF6B35)]) : null,
            color: active ? null : const Color(0xFF14141E),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: active ? Colors.transparent : Colors.white.withOpacity(0.07)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(t.icon, size: 12, color: active ? Colors.white : Colors.white.withOpacity(0.35)),
            const SizedBox(width: 6),
            Text(t.label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                color: active ? Colors.white : Colors.white.withOpacity(0.4))),
          ]),
        ),
      );
    }).toList()),
  );

  Widget _body() {
    if (_loading) return _shimmer();
    if (_error != null) return _errorView();
    if (!_searched) return _hint();
    if (_results.isEmpty) return _empty();
    return _grid();
  }

  Widget _grid() => GridView.builder(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.62, crossAxisSpacing: 12, mainAxisSpacing: 12),
    itemCount: _results.length,
    itemBuilder: (_, i) {
      final m = _results[i];
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _MovieDetailScreen(summary: m))),
        child: Container(
          decoration: BoxDecoration(color: const Color(0xFF10101A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.06))),
          clipBehavior: Clip.antiAlias,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Stack(fit: StackFit.expand, children: [
              m.poster != null
                  ? Image.network(m.poster!, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _posterPlaceholder())
                  : _posterPlaceholder(),
              Positioned(top: 8, left: 8, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(5)),
                child: Text(m.type.toUpperCase(),
                    style: const TextStyle(color: Color(0xFFFF6B35), fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
              )),
            ])),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(m.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, height: 1.3)),
                const SizedBox(height: 3),
                Text(m.year, style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 10)),
              ]),
            ),
          ]),
        ),
      );
    },
  );

  Widget _shimmer() => AnimatedBuilder(
    animation: _shimCtrl,
    builder: (_, __) {
      final c = ColorTween(begin: const Color(0xFF14141E), end: const Color(0xFF22222E)).evaluate(_shimCtrl)!;
      return GridView.count(crossAxisCount: 2, childAspectRatio: 0.62,
          crossAxisSpacing: 12, mainAxisSpacing: 12,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
          children: List.generate(6, (_) => Container(
              decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(16)))));
    },
  );

  Widget _hint() => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 72, height: 72, decoration: BoxDecoration(shape: BoxShape.circle,
        gradient: RadialGradient(colors: [const Color(0xFFE50914).withOpacity(0.15), Colors.transparent])),
        child: const Icon(Icons.movie_filter_outlined, color: Color(0xFFE50914), size: 36)),
    const SizedBox(height: 18),
    const Text('Discover Movies & Shows', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
    const SizedBox(height: 8),
    Text('Type a title above to search', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 13)),
  ]));

  Widget _errorView() => Center(child: Padding(
    padding: const EdgeInsets.all(32),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.error_outline_rounded, color: Color(0xFFE50914), size: 52),
      const SizedBox(height: 14),
      Text(_error!, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 13, height: 1.6)),
      const SizedBox(height: 18),
      TextButton.icon(onPressed: _search,
          icon: const Icon(Icons.refresh_rounded, color: Color(0xFFFF6B35)),
          label: const Text('Retry', style: TextStyle(color: Color(0xFFFF6B35)))),
    ]),
  ));

  Widget _empty() => Center(child: Text('No results for "${_ctrl.text}"',
      style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 13)));

  Widget _posterPlaceholder() => Container(color: const Color(0xFF14141E),
      child: const Center(child: Icon(Icons.image_not_supported_outlined, color: Colors.white12, size: 32)));
}

class _TypeF {
  const _TypeF(this.label, this.value, this.icon);
  final String label, value; final IconData icon;
}

// ─────────────────────────────────────────────
//  MOVIE DETAIL SCREEN
// ─────────────────────────────────────────────
class _MovieDetailScreen extends StatefulWidget {
  const _MovieDetailScreen({required this.summary});
  final MovieSummary summary;
  @override State<_MovieDetailScreen> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<_MovieDetailScreen> {
  MovieDetail? _d;
  bool _loading = true;
  String? _error;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final d = await OmdbService.detail(widget.summary.imdbId);
      setState(() { _d = d; _loading = false; });
    } catch (e) {
      setState(() { _error = e.toString().replaceFirst('Exception: ', ''); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF08080F),
    body: _loading
        ? const Center(child: CircularProgressIndicator(color: Color(0xFFE50914), strokeWidth: 2))
        : _error != null
        ? Center(child: Text(_error!, style: const TextStyle(color: Colors.white54)))
        : _content(_d!),
  );

  Widget _content(MovieDetail d) => CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: [
      SliverAppBar(
        expandedHeight: 360,
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
          background: Stack(fit: StackFit.expand, children: [
            d.poster != null
                ? Image.network(d.poster!, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF14141E)))
                : const ColoredBox(color: Color(0xFF14141E)),
            Container(decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.2), const Color(0xFF08080F)], stops: const [0.4, 1.0]))),
            Positioned(
              top: 60, right: 18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                        color: d.ratingColor.withOpacity(0.2), borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: d.ratingColor.withOpacity(0.5))),
                    child: Column(children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      const SizedBox(height: 2),
                      Text(d.imdbRating, style: TextStyle(color: d.ratingColor, fontSize: 17, fontWeight: FontWeight.w800)),
                      Text('IMDb', style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 9)),
                    ]),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      SliverToBoxAdapter(child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 48),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d.title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.6)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: [
            _chip(d.year), _chip(d.rated), _chip(d.runtime),
            ...(d.genre.split(',').take(3).map((g) => _chip(g.trim())).toList()),
          ]),
          if (d.awards != null) ...[
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color(0xFFFFD166).withOpacity(0.12), const Color(0xFFFF6B35).withOpacity(0.06)]),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFFD166).withOpacity(0.3))),
              child: Row(children: [
                const Icon(Icons.emoji_events_rounded, color: Color(0xFFFFD166), size: 16),
                const SizedBox(width: 10),
                Expanded(child: Text(d.awards!, style: const TextStyle(color: Color(0xFFFFD166), fontSize: 12, height: 1.4))),
              ]),
            ),
          ],
          const SizedBox(height: 22),
          _sectionLabel('Plot'),
          const SizedBox(height: 10),
          Text(d.plot, style: const TextStyle(color: Color(0xFFBBBBCC), fontSize: 14, height: 1.7)),
          if (d.ratings.isNotEmpty) ...[
            const SizedBox(height: 22),
            _sectionLabel('Ratings'),
            const SizedBox(height: 12),
            Row(children: d.ratings.take(3).map((r) => Expanded(child: _ratingCard(r))).toList()),
          ],
          const SizedBox(height: 22),
          _sectionLabel('Cast & Crew'),
          const SizedBox(height: 14),
          _infoRow(Icons.person_outline_rounded, 'Director', d.director),
          _infoRow(Icons.edit_outlined, 'Writer', d.writer.length > 60 ? '${d.writer.substring(0, 60)}…' : d.writer),
          _infoRow(Icons.groups_outlined, 'Stars', d.actors.length > 60 ? '${d.actors.substring(0, 60)}…' : d.actors),
          const SizedBox(height: 22),
          _sectionLabel('Details'),
          const SizedBox(height: 14),
          GridView.count(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 2.4,
            children: [
              _detailCell('Released', d.released),
              _detailCell('Language', d.language),
              _detailCell('Country', d.country),
              if (d.boxOffice != null) _detailCell('Box Office', d.boxOffice!),
              _detailCell('IMDb Votes', d.imdbVotes),
              if (d.metascore != null) _detailCell('Metascore', '${d.metascore}/100'),
            ],
          ),
        ]),
      )),
    ],
  );

  Widget _chip(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: const Color(0xFF14141E), borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.08))),
    child: Text(t, style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 11, fontWeight: FontWeight.w500)),
  );

  Widget _sectionLabel(String t) => Row(children: [
    Container(width: 3, height: 14, decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFE50914), Color(0xFFFF6B35)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(2))),
    const SizedBox(width: 10),
    Text(t.toUpperCase(), style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
  ]);

  Widget _ratingCard(_Rating r) => Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFF14141E), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06))),
    child: Column(children: [
      Text(r.value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(r.source == 'Internet Movie Database' ? 'IMDb' : r.source == 'Rotten Tomatoes' ? 'Rotten\nTomatoes' : r.source,
          textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9, height: 1.3)),
    ]),
  );

  Widget _infoRow(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFFE50914), size: 15),
      const SizedBox(width: 10),
      SizedBox(width: 68, child: Text(label,
          style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11, fontWeight: FontWeight.w500))),
      Expanded(child: Text(value, style: const TextStyle(color: Color(0xFFCCCCDD), fontSize: 12, height: 1.4))),
    ]),
  );

  Widget _detailCell(String label, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: const Color(0xFF10101A), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(label, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9, letterSpacing: 0.5, fontWeight: FontWeight.w600)),
      const SizedBox(height: 3),
      Text(value, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );
}
