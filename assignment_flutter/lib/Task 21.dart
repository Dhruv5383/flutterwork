// import 'package:flutter/material.dart';
// import 'Task 21_2.dart';
//
// class FirstScreen extends StatefulWidget {
//   const FirstScreen({super.key});
//
//   @override
//   State<FirstScreen> createState() => _FirstScreenState();
// }
//
// class _FirstScreenState extends State<FirstScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("First Screen"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SecondScreen(),
//               ),
//             );
//           },
//           child: const Text("Go to Second Screen"),
//         ),
//       ),
//     );
//   }
// }
//
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
//       appBar: AppBar(
//         title: const Text("Second Screen"),
//         backgroundColor: Colors.green,
//       ),
//       body: const Center(
//         child: Text(
//           "Welcome to the Second Screen!",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }




// final second code Text and TextStyle

import 'package:flutter/material.dart';

import 'Task 21_2.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the First Screen!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondScreen(),
                  ),
                );
              },
              child: const Text("Go to Second Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

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
//       appBar: AppBar(
//         title: const Text("Second Screen"),
//         backgroundColor: Colors.green,
//       ),
//       body: const Center(
//         child: Text(
//           "Welcome to the Second Screen!",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
