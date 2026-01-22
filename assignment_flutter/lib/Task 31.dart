// import 'package:flutter/material.dart';
//
// class CardWithFabExample extends StatefulWidget {
//   const CardWithFabExample({super.key});
//
//   @override
//   State<CardWithFabExample> createState() => _CardWithFabExampleState();
// }
//
// class _CardWithFabExampleState extends State<CardWithFabExample> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: const Text('Card With Fab Example'),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         // ConstrainedBox is used here just to make the card look nice in the center
//         child: SizedBox(
//           width: 300,
//           height: 200,
//           // 1. The Stack allows us to overlay widgets on top of each other
//           child: Stack(
//             children: [
//               // 2. The Bottom Layer: The Card UI
//               Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Task Progress",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Items completed: $_counter",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // 3. The Top Layer: The Floating Action Button
//               // Positioned allows us to place the widget at specific coordinates within the Stack
//               Positioned(
//                 bottom: 16,
//                 right: 16,
//                 child: FloatingActionButton(
//                   onPressed: _incrementCounter,
//                   backgroundColor: Colors.deepPurple,
//                   mini: true, // Making it slightly smaller to fit the card aesthetic
//                   child: const Icon(Icons.add, color: Colors.white),
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
// class CardWithFabPage extends StatefulWidget {
//   @override
//   _CardWithFabPageState createState() => _CardWithFabPageState();
// }
//
// class _CardWithFabPageState extends State<CardWithFabPage> {
//   int count = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: Center(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//
//             // Card UI
//             Container(
//               width: 280,
//               height: 180,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "My Card",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     "Button tapped $count times",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Floating Action Button
//             Positioned(
//               bottom: -20,
//               right: -20,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   setState(() {
//                     count++;
//                   });
//                 },
//                 child: Icon(Icons.add),
//               ),
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
// class AnimatedCardFabPage extends StatefulWidget {
//   @override
//   _AnimatedCardFabPageState createState() => _AnimatedCardFabPageState();
// }
//
// class _AnimatedCardFabPageState extends State<AnimatedCardFabPage>
//     with SingleTickerProviderStateMixin {
//   int likes = 0;
//   late AnimationController _controller;
//   late Animation<double> _scaleAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 200),
//     );
//     _scaleAnim = Tween(begin: 1.0, end: 1.2).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void onFabTap() async {
//     await _controller.forward();
//     await _controller.reverse();
//     setState(() => likes++);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade300,
//       body: Center(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//
//             // Gradient Card
//             Container(
//               width: 300,
//               height: 190,
//               padding: EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18),
//                 gradient: LinearGradient(
//                   colors: [Colors.deepPurple, Colors.purpleAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 12,
//                     offset: Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Gradient Card",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 14),
//                   Text(
//                     "Likes: $likes",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Animated FAB
//             Positioned(
//               bottom: -22,
//               right: -22,
//               child: ScaleTransition(
//                 scale: _scaleAnim,
//                 child: FloatingActionButton(
//                   backgroundColor: Colors.orange,
//                   onPressed: onFabTap,
//                   child: Icon(Icons.favorite),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








import 'dart:ui';
import 'package:flutter/material.dart';

import 'Task 31_2.dart';

class AllInOneCardDemo extends StatefulWidget {
  @override
  _AllInOneCardDemoState createState() => _AllInOneCardDemoState();
}

class _AllInOneCardDemoState extends State<AllInOneCardDemo> {
  int swipeIndex = 0;

  final List<Color> colors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards UI Demo"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🧊 GLASSMORPHISM CARD
            Text("🧊 Glassmorphism Card"),
            SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://picsum.photos/400/200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Text(
                        "Glass Card",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            /// 🚀 HERO ANIMATION
            Text("🚀 Hero Animation"),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeroDetailPage(),
                  ),
                );
              },
              child: Hero(
                tag: "hero-card",
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Tap Me",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            /// 🧱 GRIDVIEW CARDS
            Text("🧱 Multiple Cards (GridView)"),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Card ${index + 1}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),

            SizedBox(height: 30),

            /// 👉👈 SWIPEABLE CARDS
            Text("👉👈 Swipeable Cards"),
            SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: List.generate(3, (index) {
                return Dismissible(
                  key: ValueKey(index),
                  direction: DismissDirection.horizontal,
                  onDismissed: (_) {
                    setState(() {
                      swipeIndex++;
                    });
                  },
                  child: Container(
                    height: 160,
                    width: 260,
                    decoration: BoxDecoration(
                      color: colors[(swipeIndex + index) % colors.length],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Swipe Me",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// /// 🚀 HERO DETAIL PAGE
// class HeroDetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Hero Detail")),
//       body: Center(
//         child: Hero(
//           tag: "hero-card",
//           child: Container(
//             height: 250,
//             width: 300,
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               "Hero Page",
//               style: TextStyle(
//                   fontSize: 26,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
