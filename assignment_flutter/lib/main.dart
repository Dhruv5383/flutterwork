import 'package:assignment_flutter/task%2038%20demo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MAMA.dart';
import 'Task 01.dart';
import 'Task 10.dart';
import 'Task 11.dart';
import 'Task 02.dart';
import 'Task 03.dart';
import 'Task 04.dart';
import 'Task 05.dart';
import 'Task 06.dart';
import 'Task 08.dart';
import 'Task 09.dart';
import 'Task 12.dart';
import 'Task 13.dart';
import 'Task 14.dart';
import 'Task 15.dart';
import 'Task 16.dart';
import 'Task 17.dart';
import 'Task 18.dart';
import 'Task 19.dart';
import 'Task 20.dart';
import 'Task 21.dart';
import 'Task 22.dart';
import 'Task 22_2.dart';
import 'Task 23.dart';
import 'Task 24.dart';
import 'Task 25 to 28.dart';
import 'Task 25.dart';
import 'Task 26.dart';
import 'Task 27.dart';
import 'Task 28.dart';
import 'Task 29 to 32.dart';
import 'Task 29.dart';
import 'Task 30.dart';
import 'Task 31.dart';
import 'Task 32.dart';
import 'Task 32_2.dart';
import 'Task 33 to 36.dart';
import 'Task 33.dart';
import 'Task 34.dart';
import 'Task 35.dart';
import 'Task 36.dart';
import 'Task 37.dart';

// void main() {
//   runApp(const mytext1());
// }
//
// class mytext1 extends StatelessWidget {
//   const mytext1 ({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: Task_38_105());
//   }
// }


// class TextWidget extends StatelessWidget {
//   const TextWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App', style: TextStyle(fontSize: 25,
//           color: Colors.black,
//           backgroundColor: Colors.white,
//         ),
//         ),
//         backgroundColor: Colors.grey,
//       ),
//       body: Container(
//         height: 100,
//         color: Colors.blue,
//         child: Center(
//           child: Text(
//             'Hello Flutter developers',
//             //'Dhruv m Patel '
//             style: TextStyle(fontSize: 20, color: Colors.blue.shade500,backgroundColor: Colors.amber),
//           ),
//         ),
//       ),
//     );
//   }
// }

// task 37
//  class MyApp extends StatefulWidget {
//    const MyApp({super.key});
//
//    @override
//   State<MyApp> createState() => _MyAppState();
//  }
//
//  class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//      return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CounterScreen(),
//      );
//    }
//  }


// task 38 main dart file
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'Task 38.dart';
// import 'Task 38_2 cart modul ( provider ).dart';
// //import 'cart_provider.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => CartProvider(),
//       child: const MyApp(),
//     ),
//   );
// }
//
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
//     return const MaterialApp(
//       home: ShoppingCartScreen(),
//     );
//   }
// }


// task 38 main dart file
//mport 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'Task 38.dart';
//import 'Task 38_2 cart modul ( provider ).dart';
//import 'cart_provider.dart';
//import 'shopping_cart_screen.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => CartProvider()..loadCart(),
//       child: const MyApp(),
//     ),
//   );
// }
//
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
//     return const MaterialApp(
//       home: ShoppingCartScreen(),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
//
// import 'Task 39.dart';
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Task 40 Login Screen.dart';
import 'Task 40_2 Auth Provider (Global State).dart';
import 'auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return auth.isLoggedIn
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}


