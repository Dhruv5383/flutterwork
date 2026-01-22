import 'package:flutter/material.dart';
import 'package:flutter_30day/pages/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Material(
//         child: Center(
//           child: Container(
//             child: Text ("Welcome TO DHRUV PATEL IN 30 DAY OF FLUTTER"),
//           ),
//         ),
//       ),
//     );
//   }
// }
