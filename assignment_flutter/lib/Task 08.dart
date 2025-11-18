// import 'package:flutter/material.dart';
//
// class NameListApp extends StatelessWidget {
//   const NameListApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Sample list of names
//     final List<String> names = [
//       'Dhruv',
//       'Riya',
//       'Aarav',
//       'Priya',
//       'Karan',
//       'Sneha',
//       'Vikram',
//       'Neha',
//       'Ananya',
//       'Raj'
//     ];
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('List of Names'),
//           backgroundColor: Colors.blueAccent,
//         ),
//         body: ListView.builder(
//           itemCount: names.length,
//           itemBuilder: (context, index) {
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//               elevation: 4,
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.blueAccent,
//                   child: Text(
//                     names[index][0], // first letter of name
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 title: Text(
//                   names[index],
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//                 onTap: () {
//                   print('${names[index]} tapped'); // prints in console
//                 },
//               ),
//             );
//           },
//         ),
//       );
//   }
// }


import 'package:flutter/material.dart';

class NameListApp extends StatelessWidget {
  const NameListApp({super.key});

  @override
  Widget build(BuildContext context) {
    // List of names
    final List<String> names = [
      'Dhruv',
      'Riya',
      'Aarav',
      'Karan',
      'Sneha',
      'Neha',
      'Raj',
      'Priya',
      'Vikram',
      'Ananya'
    ];

    return  Scaffold(
        appBar: AppBar(
           title: const Text('List of Names'),
           backgroundColor: Colors.blueAccent,
         ),
        body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                names[index],
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
        ),
      );
  }
}


// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const NameListApp());
// }
//
// class NameListApp extends StatelessWidget {
//   const NameListApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // List of names
//     final List<String> names = [
//       'Dhruv',
//       'Riya',
//       'Aarav',
//       'Karan',
//       'Sneha',
//       'Neha',
//       'Raj',
//       'Priya',
//       'Vikram',
//       'Ananya'
//     ];
//
//     return Scaffold(
//         appBar: AppBar(
//             title: const Text('List of Names'),
//             backgroundColor: Colors.blueAccent,
//           ),
//         body: ListView.builder(
//           itemCount: names.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(names[index]),
//               onTap: () {
//                 print('${names[index]} tapped');
//               },
//             );
//           },
//         ),
//       );
//   }
// }
