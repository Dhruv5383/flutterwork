// lib/main.dart
//
// MyCityConnect — Flutter App
// ────────────────────────────────────────────────────────────────────
// Firebase setup (run ONCE before first launch):
//   1. dart pub global activate flutterfire_cli
//   2. flutterfire configure
//      (creates lib/firebase_options.dart automatically)
//   3. In this file, uncomment the Firebase initialization block below.
//   4. In auth_service.dart, uncomment all Firebase lines.
//
// Without these steps the app runs fully on mock/simulation mode.
// ────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Uncomment after `flutterfire configure`:
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'Constants.dart';
import 'Contact us screen.dart';
import 'Home screen.dart';
import 'Login screen.dart';
import 'My bookings screen.dart';
import 'Profile screen.dart';
import 'Register screen.dart';
import 'Service detail screen.dart';
import 'Splash screen.dart';
// import 'utils/constants.dart';
// import 'screens/splash_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/register_screen.dart';
// import 'screens/home_screen.dart';
// import 'screens/service_detail_screen.dart';
// import 'screens/my_bookings_screen.dart';
// import 'screens/profile_screen.dart';
// import 'screens/contact_us_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // System UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // ── Firebase init (uncomment after flutterfire configure) ──────────
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // ──────────────────────────────────────────────────────────────────

  runApp(const MyCityConnectApp());
}

class MyCityConnectApp extends StatelessWidget {
  const MyCityConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case AppRoutes.splash:
        page = const SplashScreen();
        break;
      case AppRoutes.login:
        page = const LoginScreen();
        break;
      case AppRoutes.register:
        page = const RegisterScreen();
        break;
      case AppRoutes.home:
        page = const HomeScreen();
        break;
      case AppRoutes.serviceDetail:
        page = const ServiceDetailScreen();
        break;
      case AppRoutes.myBookings:
        page = const MyBookingsScreen();
        break;
      case AppRoutes.profile:
        page = const ProfileScreen();
        break;
      case AppRoutes.contactUs:
        page = const ContactUsScreen();
        break;
      default:
        page = const Scaffold(
          body: Center(child: Text('404 - Page not found')),
        );
    }

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}



// import 'package:flutter/material.dart';
//
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
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
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
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
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
