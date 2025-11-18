import 'package:assignment_flutter/Task%2023_2.dart';
import 'package:assignment_flutter/Task%2023_4.dart';
import 'package:flutter/material.dart';

import 'Task 22_2.dart';
import 'Task 22_4.dart';
import 'Task 23_3.dart';

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
//       debugShowCheckedModeBanner: false,
//       title: 'Navigation Drawer Demo',
//       home: const HomeScreen(),
//     );
//   }
// }

// ---------------- NAVIGATION DRAWER ----------------
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Navigation Drawer Demo'),
        //const Text("Home Screen"),
        backgroundColor: Colors.brown,
      ),
      body: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen23_2()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen23_3(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen23_4(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}












//Great!
// Here is the Navigation Drawer version using Navigator.pushNamed(), as you requested.
//Flutter Navigation Drawer with Named Routes
// Screens: Home, Profile, Settings
// Navigation: Navigator.pushReplacementNamed
// import 'package:flutter/material.dart';
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
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Drawer + Named Routes',
//
//       // --- ROUTES ---
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const HomeScreen(),
//         '/profile': (context) => const ProfileScreen(),
//         '/settings': (context) => const SettingsScreen(),
//       },
//     );
//   }
// }
//
// //
// // ---------------- HOME SCREEN ----------------
// //
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Home")),
//       drawer: const AppDrawer(),
//       body: const Center(
//         child: Text("This is Home Screen", style: TextStyle(fontSize: 22)),
//       ),
//     );
//   }
// }
//
// //
// // ---------------- PROFILE SCREEN ----------------
// //
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Profile")),
//       drawer: const AppDrawer(),
//       body: const Center(
//         child: Text("This is Profile Screen", style: TextStyle(fontSize: 22)),
//       ),
//     );
//   }
// }
//
// //
// // ---------------- SETTINGS SCREEN ----------------
// //
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Settings")),
//       drawer: const AppDrawer(),
//       body: const Center(
//         child: Text("This is Settings Screen", style: TextStyle(fontSize: 22)),
//       ),
//     );
//   }
// }
//
// //
// // ---------------- DRAWER ----------------
// //
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(color: Colors.blue),
//             child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
//           ),
//
//           // HOME
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text("Home"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/');
//             },
//           ),
//
//           // PROFILE
//           ListTile(
//             leading: const Icon(Icons.person),
//             title: const Text("Profile"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/profile');
//             },
//           ),
//
//           // SETTINGS
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text("Settings"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/settings');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
