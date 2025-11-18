// import 'package:flutter/material.dart';
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text(' Task 1 Hello, Flutter! '
//               'dhruv patel'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      );

  }
}
