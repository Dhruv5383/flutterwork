// import 'package:flutter/material.dart';
//
// import 'Task 21_2.dart';
//
//
// /// ------------------
// /// FIRST SCREEN
// /// ------------------
// class FirstScreen36 extends StatefulWidget {
//   const FirstScreen36({super.key});
//
//   @override
//   State<FirstScreen36> createState() => _FirstScreenState();
// }
//
// class _FirstScreenState extends State<FirstScreen36> {
//   void _navigate() {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         transitionDuration: const Duration(milliseconds: 500),
//         pageBuilder: (_, __, ___) => const SecondScreen(),
//         transitionsBuilder: (_, animation, __, child) {
//           final tween = Tween(
//             begin: const Offset(1.0, 0.0), // Right → Left
//             end: Offset.zero,
//           ).chain(
//             CurveTween(curve: Curves.easeInOut),
//           );
//
//           return SlideTransition(
//             position: animation.drive(tween),
//             child: child,
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('First Screen')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _navigate,
//           child: const Text('Go to Second Screen'),
//         ),
//       ),
//     );
//   }
// }

/// ------------------
/// SECOND SCREEN
/// ------------------
// class SecondScreen extends StatefulWidget {
//   const SecondScreen({super.key});
//
//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Screen')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Go Back'),
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';

import 'Task 36_2.dart';

/// ------------------
/// HOME SCREEN
/// ------------------
class HomeScreen36 extends StatefulWidget {
  const HomeScreen36({super.key});

  @override
  State<HomeScreen36> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen36> {
  void _openDetails() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const DetailsScreen36(),
        transitionsBuilder: (_, animation, __, child) {
          final slideTween = Tween(
            begin: const Offset(0.0, 1.0), // Bottom → Top
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeOutCubic),
          );

          final fadeTween = Tween<double>(
            begin: 0.0,
            end: 1.0,
          );

          return SlideTransition(
            position: animation.drive(slideTween),
            child: FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: _openDetails,
          child: const Text('Open Details'),
        ),
      ),
    );
  }
}

/// ------------------
/// DETAILS SCREEN
/// ------------------
// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({super.key});
//
//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }
//
// class _DetailsScreenState extends State<DetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Details')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Back'),
//         ),
//       ),
//     );
//   }
// }
