import 'package:flutter/material.dart';
import 'Q1 Home screen.dart';
import 'Q1 Pref service.dart';
//import 'pref_service.dart';
//import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PrefsApp());
}

class PrefsApp extends StatefulWidget {
  const PrefsApp({super.key});

  @override
  State<PrefsApp> createState() => _PrefsAppState();
}

class _PrefsAppState extends State<PrefsApp> {
  UserPrefs? _prefs;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await PrefService.load();
    setState(() => _prefs = p);
  }

  void _onUpdate(UserPrefs p) {
    setState(() => _prefs = p);
    PrefService.save(p);
  }

  @override
  Widget build(BuildContext context) {
    // Show splash while loading
    if (_prefs == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF0A0A14),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: Color(0xFF6C63FF),
                  strokeWidth: 2,
                ),
                const SizedBox(height: 20),
                Text(
                  'Loading preferences…',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final p = _prefs!;
    final accent = AppColors.accents[p.accentIndex];
    final fontSize = AppColors.fontSizes[p.fontSizeIndex];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PrefsApp',
      themeMode: p.darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: _buildTheme(accent, fontSize, dark: false),
      darkTheme: _buildTheme(accent, fontSize, dark: true),
      home: HomeScreen(prefs: p, onUpdate: _onUpdate),
    );
  }

  ThemeData _buildTheme(Color accent, double fontSize, {required bool dark}) {
    return ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: dark ? Brightness.dark : Brightness.light,
      ).copyWith(primary: accent),
      scaffoldBackgroundColor:
      dark ? const Color(0xFF0A0A14) : const Color(0xFFF4F4FB),
      cardColor: dark ? const Color(0xFF12121E) : Colors.white,
      textTheme: TextTheme(
        bodySmall: TextStyle(fontSize: fontSize - 2),
        bodyMedium: TextStyle(fontSize: fontSize),
        bodyLarge: TextStyle(fontSize: fontSize + 2),
        titleMedium:
        TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.w600),
        titleLarge:
        TextStyle(fontSize: fontSize + 6, fontWeight: FontWeight.w700),
      ),
    );
  }
}