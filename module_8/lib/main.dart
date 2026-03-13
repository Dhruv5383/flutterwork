import 'package:flutter/material.dart';
import 'package:module_8/Q2%20Home%20screen.dart';

import 'Q1 shared_preferences.dart';

import 'package:flutter/material.dart';
import 'Q1 Home screen.dart';
import 'Q1 Pref service.dart';
//import 'pref_service.dart';
//import 'home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Q2 App theme.dart';
import 'Q2 Task repository.dart';
// import 'task_repository.dart';
// import 'app_theme.dart';
// import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode (optional — remove for landscape support)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Style the system UI overlay
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // Initialise Hive and open the tasks box
  await TaskRepository.init();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive To-Do',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const Q2HomeScreen(),
    );
  }
}
// Q1 final code
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const PrefsApp());
// }
//
// class PrefsApp extends StatefulWidget {
//   const PrefsApp({super.key});
//
//   @override
//   State<PrefsApp> createState() => _PrefsAppState();
// }
//
// class _PrefsAppState extends State<PrefsApp> {
//   UserPrefs? _prefs;
//
//   @override
//   void initState() {
//     super.initState();
//     _load();
//   }
//
//   Future<void> _load() async {
//     final p = await PrefService.load();
//     setState(() => _prefs = p);
//   }
//
//   void _onUpdate(UserPrefs p) {
//     setState(() => _prefs = p);
//     PrefService.save(p);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Show splash while loading
//     if (_prefs == null) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           backgroundColor: const Color(0xFF0A0A14),
//           body: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const CircularProgressIndicator(
//                   color: Color(0xFF6C63FF),
//                   strokeWidth: 2,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Loading preferences…',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.4),
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     final p = _prefs!;
//     final accent = AppColors.accents[p.accentIndex];
//     final fontSize = AppColors.fontSizes[p.fontSizeIndex];
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'PrefsApp',
//       themeMode: p.darkMode ? ThemeMode.dark : ThemeMode.light,
//       theme: _buildTheme(accent, fontSize, dark: false),
//       darkTheme: _buildTheme(accent, fontSize, dark: true),
//       home: HomeScreen(prefs: p, onUpdate: _onUpdate),
//     );
//   }
//
//   ThemeData _buildTheme(Color accent, double fontSize, {required bool dark}) {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: dark ? Brightness.dark : Brightness.light,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: accent,
//         brightness: dark ? Brightness.dark : Brightness.light,
//       ).copyWith(primary: accent),
//       scaffoldBackgroundColor:
//       dark ? const Color(0xFF0A0A14) : const Color(0xFFF4F4FB),
//       cardColor: dark ? const Color(0xFF12121E) : Colors.white,
//       textTheme: TextTheme(
//         bodySmall: TextStyle(fontSize: fontSize - 2),
//         bodyMedium: TextStyle(fontSize: fontSize),
//         bodyLarge: TextStyle(fontSize: fontSize + 2),
//         titleMedium:
//         TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.w600),
//         titleLarge:
//         TextStyle(fontSize: fontSize + 6, fontWeight: FontWeight.w700),
//       ),
//     );
//   }
// }







// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
