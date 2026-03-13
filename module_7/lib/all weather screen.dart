import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ── API KEY ──────────────────────────────────
// Get free key at https://openweathermap.org/api
const _weatherApiKey = 'https://geocoding-api.open-meteo.com/v1/search';

// ─────────────────────────────────────────────
//  MODEL
// ─────────────────────────────────────────────
class WeatherData {
  final String city, country, description, icon;
  final double tempC, feelsLikeC, tempMinC, tempMaxC;
  final int humidity, pressure, visibility;
  final double windSpeed;
  final DateTime sunrise, sunset;

  WeatherData({
    required this.city, required this.country,
    required this.description, required this.icon,
    required this.tempC, required this.feelsLikeC,
    required this.tempMinC, required this.tempMaxC,
    required this.humidity, required this.pressure,
    required this.visibility, required this.windSpeed,
    required this.sunrise, required this.sunset,
  });

  factory WeatherData.fromJson(Map<String, dynamic> j) {
    final m = j['main'], w = j['wind'], s = j['sys'];
    return WeatherData(
      city: j['name'],
      country: s['country'],
      description: j['weather'][0]['description'],
      icon: j['weather'][0]['icon'],
      tempC: (m['temp'] as num).toDouble(),
      feelsLikeC: (m['feels_like'] as num).toDouble(),
      tempMinC: (m['temp_min'] as num).toDouble(),
      tempMaxC: (m['temp_max'] as num).toDouble(),
      humidity: m['humidity'],
      pressure: m['pressure'],
      visibility: j['visibility'] ?? 10000,
      windSpeed: (w['speed'] as num).toDouble(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(s['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(s['sunset'] * 1000),
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
  String _fmt(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m ${dt.hour < 12 ? 'AM' : 'PM'}';
  }
  String get sunriseStr => _fmt(sunrise);
  String get sunsetStr => _fmt(sunset);

  List<Color> get gradientColors {
    if (icon.contains('01')) return [const Color(0xFF1A6DCC), const Color(0xFF56AEFF)];
    if (icon.contains('02') || icon.contains('03') || icon.contains('04'))
      return [const Color(0xFF2C3E50), const Color(0xFF4A5568)];
    if (icon.contains('09') || icon.contains('10'))
      return [const Color(0xFF1A1A2E), const Color(0xFF16213E)];
    if (icon.contains('11')) return [const Color(0xFF0F0F23), const Color(0xFF2D1B69)];
    if (icon.contains('13')) return [const Color(0xFF2C3E6B), const Color(0xFF7F91B3)];
    return [const Color(0xFF1A1A2E), const Color(0xFF16213E)];
  }
}

// ─────────────────────────────────────────────
//  SERVICE
// ─────────────────────────────────────────────
class WeatherService {
  static Future<WeatherData> fetch(String city) async {
    final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
          '?q=${Uri.encodeComponent(city)}&appid=$_weatherApiKey&units=metric',
    );
    final res = await http.get(uri);
    if (res.statusCode == 200) return WeatherData.fromJson(jsonDecode(res.body));
    if (res.statusCode == 404) throw Exception('City "$city" not found');
    if (res.statusCode == 401) throw Exception('Invalid API key — get one at openweathermap.org');
    throw Exception('Error ${res.statusCode}');
  }
}

// ─────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────
class AllWeatherScreen extends StatefulWidget {
  const AllWeatherScreen({super.key});
  @override
  State<AllWeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<AllWeatherScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  WeatherData? _data;
  bool _loading = false;
  String? _error;
  final _ctrl = TextEditingController();
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fetch('London');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetch(String city) async {
    setState(() { _loading = true; _error = null; });
    _fadeCtrl.reset();
    try {
      final d = await WeatherService.fetch(city);
      setState(() { _data = d; _loading = false; });
      _fadeCtrl.forward();
    } catch (e) {
      setState(() { _error = e.toString().replaceFirst('Exception: ', ''); _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = _data?.gradientColors ?? [const Color(0xFF0D0D1A), const Color(0xFF1A1A2E)];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        child: Column(children: [
          _header(),
          _searchBar(),
          const SizedBox(height: 8),
          Expanded(child: _body()),
        ]),
      ),
    );
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
    child: Row(children: [
      const Icon(Icons.wb_sunny_rounded, color: Color(0xFF56AEFF), size: 22),
      const SizedBox(width: 10),
      const Text('Weather', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
      const Spacer(),
      Text(
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      ),
    ]),
  );

  Widget _searchBar() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Row(children: [
            const SizedBox(width: 16),
            const Icon(Icons.search_rounded, color: Colors.white54, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _ctrl,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                onSubmitted: (v) { if (v.isNotEmpty) _fetch(v); },
                decoration: const InputDecoration(
                  hintText: 'Search city…',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none, isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            TextButton(
              onPressed: () { if (_ctrl.text.isNotEmpty) _fetch(_ctrl.text.trim()); },
              child: const Text('Go', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ),
    ),
  );

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator(color: Colors.white54, strokeWidth: 2));
    if (_error != null) return _errorView();
    if (_data == null) return const SizedBox();
    return FadeTransition(opacity: _fadeAnim, child: _weatherContent(_data!));
  }

  Widget _errorView() => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.cloud_off_rounded, color: Colors.white38, size: 56),
        const SizedBox(height: 16),
        Text(_error!, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60, fontSize: 14, height: 1.5)),
      ]),
    ),
  );

  Widget _weatherContent(WeatherData w) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
    child: Column(children: [
      // Hero
      Text('${w.city}, ${w.country}',
          style: const TextStyle(color: Colors.white60, fontSize: 15, letterSpacing: 1.2, fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      Image.network(w.iconUrl, width: 90, height: 90,
          errorBuilder: (_, __, ___) => const Icon(Icons.wb_sunny, size: 80, color: Colors.white70)),
      Text('${w.tempC.round()}°',
          style: const TextStyle(color: Colors.white, fontSize: 88, fontWeight: FontWeight.w200, height: 1, letterSpacing: -4)),
      const SizedBox(height: 6),
      Text(w.description.toUpperCase(),
          style: const TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 2.5, fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _heroChip('H: ${w.tempMaxC.round()}°'),
        const SizedBox(width: 10),
        _heroChip('L: ${w.tempMinC.round()}°'),
        const SizedBox(width: 10),
        _heroChip('Feels ${w.feelsLikeC.round()}°'),
      ]),
      const SizedBox(height: 28),
      // Stats grid
      GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.7,
        children: [
          _statCard(Icons.water_drop_outlined, 'Humidity', '${w.humidity}%'),
          _statCard(Icons.air_rounded, 'Wind', '${w.windSpeed.round()} m/s'),
          _statCard(Icons.visibility_outlined, 'Visibility', '${(w.visibility / 1000).toStringAsFixed(1)} km'),
          _statCard(Icons.speed_rounded, 'Pressure', '${w.pressure} hPa'),
        ],
      ),
      const SizedBox(height: 12),
      // Sun card
      _sunCard(w),
    ]),
  );

  Widget _heroChip(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.12)),
    ),
    child: Text(t, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500)),
  );

  Widget _statCard(IconData icon, String label, String value) => ClipRRect(
    borderRadius: BorderRadius.circular(18),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Icon(icon, color: Colors.white54, size: 18),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 0.8, fontWeight: FontWeight.w500)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          ]),
        ]),
      ),
    ),
  );

  Widget _sunCard(WeatherData w) {
    final now = DateTime.now();
    final total = w.sunset.millisecondsSinceEpoch - w.sunrise.millisecondsSinceEpoch;
    final elapsed = now.millisecondsSinceEpoch - w.sunrise.millisecondsSinceEpoch;
    final progress = (elapsed / total).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('SUNRISE / SUNSET', style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD166)),
                minHeight: 5,
              ),
            ),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _sunTime(Icons.wb_sunny_outlined, 'Sunrise', w.sunriseStr),
              _sunTime(Icons.nightlight_round, 'Sunset', w.sunsetStr),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _sunTime(IconData icon, String label, String time) => Row(children: [
    Icon(icon, color: const Color(0xFFFFD166), size: 16),
    const SizedBox(width: 8),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      Text(time, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
    ]),
  ]);
}
