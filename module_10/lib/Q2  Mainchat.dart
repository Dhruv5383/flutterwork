import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Q2 Auth screen.dart';
import 'Q2 Auth service.dart';
import 'Q2 home screen.dart';
import 'firebase_options.dart';
//import 'screens/auth_screen.dart';
//import 'screens/home_screen.dart';
//import 'services/auth_service.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const ChatApp());
// }

// class ChatApp extends StatelessWidget {
//   const ChatApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Chat',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF6C63FF),
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//         fontFamily: 'Roboto',
//         appBarTheme: const AppBarTheme(
//           centerTitle: true,
//           elevation: 0,
//         ),
//       ),
//       home: const AuthWrapper(),
//     );
//   }
// }

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const AuthScreen();
      },
    );
  }
}