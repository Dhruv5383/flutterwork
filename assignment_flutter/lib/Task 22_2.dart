import 'package:flutter/material.dart';

import 'Task 22_3.dart';
import 'Task 22_4.dart';

void main() {
  runApp(const HomeScreen());
}

// ---------------- HOME SCREEN ----------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "Hello from Home Screen!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(data: message),
                  ),
                );
              },
              child: const Text("Go to Details Screen"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Text("Go to Settings Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

// // ---------------- DETAILS SCREEN ----------------
//
// class DetailsScreen extends StatefulWidget {
//   final String data;
//   const DetailsScreen({super.key, required this.data});
//
//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }
//
// class _DetailsScreenState extends State<DetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Details Screen"),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: Text(
//           "Received: ${widget.data}",
//           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// ---------------- SETTINGS SCREEN ----------------

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Settings Screen"),
//         backgroundColor: Colors.orange,
//       ),
//       body: const Center(
//         child: Text(
//           "Settings Page",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
