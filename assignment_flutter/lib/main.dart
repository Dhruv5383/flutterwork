import 'package:flutter/material.dart';

import 'Task 01.dart';
import 'Task 10.dart';
import 'Task 11.dart';
import 'Task 02.dart';
import 'Task 03.dart';
import 'Task 04.dart';
import 'Task 05.dart';
import 'Task 06.dart';
import 'Task 08.dart';
import 'Task 09.dart';
import 'Task 12.dart';
import 'Task 13.dart';
import 'Task 14.dart';
import 'Task 15.dart';
import 'Task 16.dart';
import 'Task 17.dart';
import 'Task 18.dart';
import 'Task 19.dart';
import 'Task 20.dart';
import 'Task 21.dart';
import 'Task 22.dart';
import 'Task 23.dart';
import 'Task 24.dart';
import 'Task 25.dart';

void main() {
  runApp(const mytext1());
}

class mytext1 extends StatelessWidget {
  const mytext1 ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SingleFileTodoApp());
  }
}
//
// class TextWidget extends StatelessWidget {
//   const TextWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App', style: TextStyle(fontSize: 25,
//           color: Colors.black,
//           backgroundColor: Colors.white,
//         ),
//         ),
//         backgroundColor: Colors.grey,
//       ),
//       body: Container(
//         height: 100,
//         color: Colors.blue,
//         child: Center(
//           child: Text(
//             'Hello Flutter developers',
//             //'Dhruv m Patel '
//             style: TextStyle(fontSize: 20, color: Colors.blue.shade500,backgroundColor: Colors.amber),
//           ),
//         ),
//       ),
//     );
//   }
// }

