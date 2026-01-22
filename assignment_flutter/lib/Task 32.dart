// import 'package:flutter/material.dart';
//
// class CustomStackButton extends StatefulWidget {
//   @override
//   State<CustomStackButton> createState() => _CustomStackButtonState();
// }
//
// class _CustomStackButtonState extends State<CustomStackButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("Button Pressed")),
//             );
//           },
//           child: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               // Button base
//               Container(
//                 width: 180,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16),
//                   child: Text(
//                     "Upload",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Floating icon
//               Positioned(
//                 top: -18,
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 6,
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.cloud_upload,
//                     color: Colors.blue,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
//
// class StackOverlappingButton extends StatefulWidget {
//   const StackOverlappingButton({super.key});
//
//   @override
//   State<StackOverlappingButton> createState() => _StackOverlappingButtonState();
// }
//
// class _StackOverlappingButtonState extends State<StackOverlappingButton> {
//   bool _isPressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900], // Dark background to make the button pop
//       appBar: AppBar(
//         title: const Text('Stack Overlay Button'),
//         backgroundColor: Colors.teal,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: GestureDetector(
//           onTapDown: (_) => setState(() => _isPressed = true),
//           onTapUp: (_) => setState(() => _isPressed = false),
//           onTapCancel: () => setState(() => _isPressed = false),
//           child: SizedBox(
//             width: 120,
//             height: 120,
//             // The Stack allows us to overlay the Icon on top of the Text
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // 1. Bottom Layer: The Text
//                 // We add padding to the top so it sits lower than the icon,
//                 // but not low enough to clear it completely (creating the overlap).
//                 Container(
//                   width: 100,
//                   height: 80,
//                   alignment: Alignment.bottomCenter,
//                   padding: const EdgeInsets.only(bottom: 15),
//                   decoration: BoxDecoration(
//                     color: _isPressed ? Colors.teal[800] : Colors.teal,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.teal.withOpacity(0.5),
//                         blurRadius: 15,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: const Text(
//                     "CREATE",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ),
//
//                 // 2. Top Layer: The Icon
//                 // Positioned at the top, pushing it down slightly into the text area.
//                 Positioned(
//                   top: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: _isPressed ? Colors.teal[800]! : Colors.teal,
//                         width: 4,
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.add,
//                       size: 32,
//                       color: _isPressed ? Colors.teal[800] : Colors.teal,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// final code
import 'package:flutter/material.dart';

import 'Task 32_2.dart';

void main() {
  runApp(const MaterialApp(
    home: StackOverlappingButton(),
    debugShowCheckedModeBanner: false,
  ));
}

// --- Page 1: The Main Screen with Custom Button ---
class StackOverlappingButton extends StatefulWidget {
  const StackOverlappingButton({super.key});

  @override
  State<StackOverlappingButton> createState() => _StackOverlappingButtonState();
}

class _StackOverlappingButtonState extends State<StackOverlappingButton> {
  bool _isPressed = false;

  void _handleTap() {
    // Navigate to the new page using Navigator.push
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: GestureDetector(
          // Handle the visual "press" effect
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          // Handle the navigation action
          onTap: _handleTap,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. Bottom Layer: Text Container
                Container(
                  width: 100,
                  height: 80,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: _isPressed ? Colors.teal[800] : Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    "OPEN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                // 2. Top Layer: Icon
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isPressed ? Colors.teal[800]! : Colors.teal,
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 32,
                      color: _isPressed ? Colors.teal[800] : Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // --- Page 2: The New Screen ---
// class SecondPage extends StatefulWidget {
//   const SecondPage({super.key});
//
//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }
//
// class _SecondPageState extends State<SecondPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("New Page"),
//         backgroundColor: Colors.orange,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.check_circle, size: 80, color: Colors.orange),
//             const SizedBox(height: 20),
//             const Text(
//               "You have opened the new page!",
//               style: TextStyle(fontSize: 18, color: Colors.black54),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Go back to previous screen
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text("Go Back"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







//
// import 'package:flutter/material.dart';
//
// class AnimatedStackButton extends StatefulWidget {
//   @override
//   State<AnimatedStackButton> createState() => _AnimatedStackButtonState();
// }
//
// class _AnimatedStackButtonState extends State<AnimatedStackButton> {
//   double scale = 1.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: GestureDetector(
//           onTapDown: (_) {
//             setState(() => scale = 0.95);
//           },
//           onTapUp: (_) {
//             setState(() => scale = 1.0);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("Button Clicked 🚀")),
//             );
//           },
//           onTapCancel: () {
//             setState(() => scale = 1.0);
//           },
//           child: AnimatedScale(
//             scale: scale,
//             duration: Duration(milliseconds: 120),
//             child: Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.center,
//               children: [
//                 // Button base
//                 Container(
//                   width: 190,
//                   height: 65,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.purple, Colors.blue],
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 18),
//                     child: Text(
//                       "Upload",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Floating icon
//                 Positioned(
//                   top: -22,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.cloud_upload,
//                       color: Colors.blue,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }









// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// import 'Task 32_2.dart';
//
// class GlassButtonGrid extends StatefulWidget {
//   @override
//   State<GlassButtonGrid> createState() => _GlassButtonGridState();
// }
//
// class _GlassButtonGridState extends State<GlassButtonGrid>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _bounce;
//
//   final List<IconData> icons = [
//     Icons.cloud_upload,
//     Icons.favorite,
//     Icons.camera_alt,
//     Icons.settings,
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 400),
//     );
//     _bounce = Tween(begin: 1.0, end: 1.25)
//         .chain(CurveTween(curve: Curves.elasticOut))
//         .animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[900],
//       appBar: AppBar(
//         title: Text("Glass Buttons"),
//         backgroundColor: Colors.green,
//         elevation: 0,
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(20),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 20,
//           mainAxisSpacing: 20,
//         ),
//         itemCount: icons.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               _controller.forward(from: 0);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => DetailPage(icon: icons[index], index: index),
//                 ),
//               );
//             },
//             child: Hero(
//               tag: "hero_$index",
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   // Glass button
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.white.withOpacity(0.15),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.3),
//                           ),
//                         ),
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 22),
//                           child: Text(
//                             "Action",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Floating bouncing icon
//                   Positioned(
//                     top: -18,
//                     child: ScaleTransition(
//                       scale: _bounce,
//                       child: CircleAvatar(
//                         radius: 24,
//                         backgroundColor: Colors.white,
//                         child: Icon(
//                           icons[index],
//                           color: Colors.blueGrey[900],
//                           size: 28,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
