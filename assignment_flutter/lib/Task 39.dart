import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'main.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// /// THEME PROVIDER
// class ThemeProvider extends ChangeNotifier {
//   bool _isDark = false;
//
//   bool get isDark => _isDark;
//
//   ThemeMode get themeMode =>
//       _isDark ? ThemeMode.dark : ThemeMode.light;
//
//   void toggleTheme() {
//     _isDark = !_isDark;
//     notifyListeners();
//   }
// }
//
// /// ROOT APP
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: themeProvider.themeMode,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: const ThemeSwitcherPage(),
//     );
//   }
// }

/// UI PAGE
class ThemeSwitcherPage extends StatefulWidget {
  const ThemeSwitcherPage({super.key});

  @override
  State<ThemeSwitcherPage> createState() => _ThemeSwitcherPageState();
}

class _ThemeSwitcherPageState extends State<ThemeSwitcherPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Switcher (Provider)'), backgroundColor: Colors.green,
      ),
      body: Center(
        child: SwitchListTile(
          title: Text(
            themeProvider.isDark
                ? 'Dark Mode 🌙'
                : 'Light Mode 🌞',
          ),
          value: themeProvider.isDark,
          onChanged: (_) {
            themeProvider.toggleTheme();
          },
        ),
      ),
    );
  }
}





