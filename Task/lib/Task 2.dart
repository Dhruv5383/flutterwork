// import 'package:flutter/material.dart';
//
// class MyLayoutApp_2 extends StatelessWidget {
//   const MyLayoutApp_2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Task 2'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               // Top Purple Box
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 color: const Color(0xFF8D43B3),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   '#8D43B3',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//               const SizedBox(height: 10),
//
//               // Green + Blue + Red row
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: 100,
//                       color: const Color(0xFF2AA650),
//                       alignment: Alignment.center,
//                       child: const Text(
//                         '#2AA650',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Column(
//                     children: [
//                       Container(
//                         height: 40,
//                         width: 100,
//                         color: const Color(0xFF58AAE8),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           '#58AAE8',
//                           style: TextStyle(color: Colors.white, fontSize: 14),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         height: 50,
//                         width: 100,
//                         color: const Color(0xFFE74E33),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           '#E74E33',
//                           style: TextStyle(color: Colors.white, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               const SizedBox(height: 10),
//
//               // Bottom green full-width box
//               Container(
//                 height: 60,
//                 width: double.infinity,
//                 color: const Color(0xFF2AA650),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   '#2AA650',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyLayoutApp2 extends StatelessWidget {
  const MyLayoutApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task 2'),
          backgroundColor: const Color(0xFF2AA650),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Top Purple Box
              Container(
                height: 180,
                width: double.infinity,
                color: const Color(0xFF8D43B3),
                alignment: Alignment.center,
                child: const Text(
                  '#8D43B3',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),

              // Middle Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Green Box
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 130,
                      color: const Color(0xFF2AA650),
                      alignment: Alignment.center,
                      child: const Text(
                        '#2AA650',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Right Column: Blue and Red Boxes
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: double.infinity,
                          color: const Color(0xFF58AAE8),
                          alignment: Alignment.center,
                          child: const Text(
                            '#58AAE8',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 80,
                          width: double.infinity,
                          color: const Color(0xFFE74E33),
                          alignment: Alignment.center,
                          child: const Text(
                            '#E74E33',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Bottom Green Box
              Container(
                height: 50,
                width: double.infinity,
                color: const Color(0xFF2AA650),
                alignment: Alignment.center,
                child: const Text(
                  '#2AA650',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
