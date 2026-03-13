import 'package:flutter/material.dart';

//import 'Q1 WeatherScreen.dart';
import 'Q1 screen.dart';
import 'Q2 NewsFeedScreen.dart';
import 'Q3 MovieSearchApp.dart';
import 'all movie screen.dart';
import 'all screen.dart';
// All screen
void main() => runApp(const TriApp());

class TriApp extends StatelessWidget {
  const TriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppSuite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08080F),
        fontFamily: 'Georgia',
      ),
      home: const MainShell(),
    );
  }
}

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bottom Nav Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF6C63FF),
//           brightness: Brightness.dark,
//         ),
//         useMaterial3: true,
//         fontFamily: 'SF Pro Display',
//       ),
//       home: const MovieScreen(),
//     );
//   }
// }
//Q3 final code
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
// Q2 final code
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
// Q1 final code
// void main() {
//   runApp(const WeatherLensApp());
// }
//
// class WeatherLensApp extends StatelessWidget {
//   const WeatherLensApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Weather Lens",
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF7A59)),
//         useMaterial3: true,
//         fontFamily: "SpaceGrotesk",
//       ),
//       home: const WeatherHome(),
//     );
//   }
// }
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WeatherScreen(),
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
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
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
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//
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
