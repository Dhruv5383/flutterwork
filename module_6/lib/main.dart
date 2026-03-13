import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Q1 auth_provider.dart';
import 'Q2 register_screen.dart';
import 'Q3 Feedback Form.dart';
//import 'providers/auth_provider.dart';
//import 'screens/register_screen.dart';
//Q3
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Q3 api_service.dart';
import 'Q3 feedback_provider.dart';
import 'Q3 feedback_repository.dart';
import 'Q3 feedback_screen.dart';
import 'Q3 local_storage_service.dart';
//import 'core/services/api_service.dart';
//import 'core/services/local_storage_service.dart';
//import 'features/feedback/provider/feedback_provider.dart';
//import 'features/feedback/repository/feedback_repository.dart';
//import 'features/feedback/presentation/feedback_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FeedbackProvider(
            repository: FeedbackRepository(
              apiService: ApiService(),
              localStorageService: LocalStorageService(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: FeedbackScreen(),
      ),
    );
  }
}










//Q3
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: FeedbackForm(),
//   ));
// }

// Q2
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ],
//       child: const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: RegisterScreen(),
//       ),
//     );
//   }
// }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'Q1 auth_provider.dart';
// import 'Q1 auth_screen.dart';
// import 'Q1 form.dart';
// import 'Q2 registration form.dart';
// import 'firebase_options.dart';
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
//       home: RegistrationScreen(),
//     );
//   }
// }

//
// Future<void> main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AuthProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: AuthScreen(),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RegistrationScreen(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
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
//
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
