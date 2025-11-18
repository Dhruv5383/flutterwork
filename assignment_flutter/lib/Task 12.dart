import 'package:flutter/material.dart';

class ToggleBackgroundApp extends StatefulWidget {
  const ToggleBackgroundApp({super.key});

  @override
  State<ToggleBackgroundApp> createState() => _ToggleBackgroundAppState();
}

class _ToggleBackgroundAppState extends State<ToggleBackgroundApp> {
  bool isDark = false; // toggle state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Toggle Background App'),
        backgroundColor: isDark ? Colors.white : Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              size: 100,
              color: isDark ? Colors.yellow : Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              isDark ? 'Dark Mode ON' : 'Light Mode ON',
              style: TextStyle(
                fontSize: 24,
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Switch(
              value: isDark,
              activeColor: Colors.yellow,
              inactiveThumbColor: Colors.blueAccent,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
//
// class ToggleBackgroundStateless extends StatelessWidget {
//   const ToggleBackgroundStateless({super.key});
//
//   final bool isDark = true; // fixed state, cannot change in StatelessWidget
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       appBar: AppBar(
//         title: const Text('Toggle Background (Stateless)'),
//         backgroundColor: isDark ? Colors.grey[900] : Colors.blueAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               isDark ? Icons.dark_mode : Icons.light_mode,
//               size: 100,
//               color: isDark ? Colors.yellow : Colors.orange,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               isDark ? 'Dark Mode ON' : 'Light Mode ON',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: isDark ? Colors.white : Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Switch(
//               value: true, // fixed, won't change
//               onChanged: null, // disabled because no state to update
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
