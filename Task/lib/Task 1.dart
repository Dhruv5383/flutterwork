// import 'package:flutter/material.dart';
//
// class MyColumn_1 extends StatelessWidget {
//   const MyColumn_1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("task 1"),backgroundColor: Colors.green),
//       body: Container(
//
//       ),
//     );
//   }
// }

// add to app bar without name code
// import 'package:flutter/material.dart';
//
// class MyLayoutApp extends StatelessWidget {
//   const MyLayoutApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 // Green box
//                 Container(
//                   height: 60,
//                   width: double.infinity,
//                   color: Colors.green,
//                 ),
//                 const SizedBox(height: 10),
//                 // Row with light blue and red boxes
//                 Row(
//                   children: [
//                     Container(
//                       width: 60,
//                       height: 60,
//                       color: Colors.lightBlue,
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Container(
//                         height: 60,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 // Purple large box
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     color: Colors.purple,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // Bottom light blue box
//                 Container(
//                   height: 40,
//                   width: double.infinity,
//                   color: Colors.lightBlue,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// add to app bar name  code
import 'package:flutter/material.dart';

class MyLayoutApp extends StatelessWidget {
  const MyLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('task_1'),backgroundColor: Colors.blue,),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Green box
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.green,
                ),
                const SizedBox(height: 10),
                // Row with light blue and red boxes
                Row(
                  children: [
                    Container(width: 60, height: 60, color: Colors.lightBlue),
                    const SizedBox(width: 10),
                    Expanded(child: Container(height: 60, color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 10),
                // Purple large box
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 10),
                // Bottom light blue box
                Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.lightBlue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
