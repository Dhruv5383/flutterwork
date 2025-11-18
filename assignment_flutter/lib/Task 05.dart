// import 'package:flutter/material.dart';
//
// class ResponsiveRowApp extends StatelessWidget {
//   const ResponsiveRowApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Responsive Row Layout'),
//           backgroundColor: Colors.blue,
//         ),
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             double screenWidth = constraints.maxWidth;
//
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: screenWidth * 0.25, // 25% width
//                     height: 100,
//                     color: Colors.red,
//                     child: const Center(
//                       child: Text(
//                         'Box 1',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.35, // 35% width
//                     height: 100,
//                     color: Colors.green,
//                     child: const Center(
//                       child: Text(
//                         'Box 2',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.30, // 30% width
//                     height: 100,
//                     color: Colors.blue,
//                     child: const Center(
//                       child: Text(
//                         'Box 3',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.35, // 35% width
//                     height: 100,
//                     color: Colors.blueGrey,
//                     child: const Center(
//                       child: Text(
//                         'Box 4',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.35, // 35% width
//                     height: 100,
//                     color: Colors.brown,
//                     child: const Center(
//                       child: Text(
//                         'Box 5',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.35, // 35% width
//                     height: 100,
//                     color: Colors.lightGreenAccent,
//                     child: const Center(
//                       child: Text(
//                         'Box 6',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//   }
// }


import 'package:flutter/material.dart';

class ResponsiveRowApp extends StatelessWidget {
  const ResponsiveRowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Responsive Row Layout'),
          backgroundColor: Colors.blue,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal, // enable horizontal scroll
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.20,
                    height: 100,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Box 1',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: screenWidth * 0.20,
                    height: 100,
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        'Box 2',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: screenWidth * 0.20,
                    height: 100,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Box 3',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: screenWidth * 0.20,
                    height: 100,
                    color: Colors.orange,
                    child: const Center(
                      child: Text(
                        'Box 4',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: screenWidth * 0.20,
                    height: 100,
                    color: Colors.purple,
                    child: const Center(
                      child: Text(
                        'Box 5',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
  }
}
