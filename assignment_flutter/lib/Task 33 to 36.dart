// import 'package:flutter/material.dart';
//
// import 'Task 21_2.dart';
//
// /* ------------------ HOME SCREEN ------------------ */
//
// class HomeScreentask33to36 extends StatefulWidget {
//   const HomeScreentask33to36({super.key});
//
//   @override
//   State<HomeScreentask33to36> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreentask33to36> {
//   bool expanded = false;
//   bool pulse = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("All Animations Demo")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             /* -------- 1️⃣ Fade-in Network Image -------- */
//             FadeInImage(
//               height: 160,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeholder: const AssetImage("assets/placeholder.png"),
//               image: const NetworkImage(
//                 "https://picsum.photos/500/300",
//               ),
//               fadeInDuration: const Duration(milliseconds: 800),
//             ),
//
//             const SizedBox(height: 20),
//
//             /* -------- 2️⃣ Expand / Collapse Section -------- */
//             ElevatedButton(
//               onPressed: () {
//                 setState(() => expanded = !expanded);
//               },
//               child: Text(expanded ? "Collapse" : "Expand"),
//             ),
//
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeInOut,
//               height: expanded ? 100 : 0,
//               margin: const EdgeInsets.only(top: 10),
//               padding: const EdgeInsets.all(12),
//               color: Colors.blue.shade100,
//               child: const Text(
//                 "This content expands and collapses smoothly.",
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /* -------- 3️⃣ Pulsing Button -------- */
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 1.0, end: pulse ? 1.2 : 1.0),
//               duration: const Duration(milliseconds: 300),
//               builder: (context, scale, child) {
//                 return Transform.scale(
//                   scale: scale,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       setState(() => pulse = !pulse);
//                     },
//                     child: const Text("Pulse Button"),
//                   ),
//                 );
//               },
//             ),
//
//             const Spacer(),
//
//             /* -------- 4️⃣ Slide Transition Navigation -------- */
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(_slideRoute());
//               },
//               child: const Text("Go To Next Screen"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /* ------------------ SLIDE ROUTE ------------------ */
//
// Route _slideRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//     const SecondScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0);
//       const end = Offset.zero;
//       final tween = Tween(begin: begin, end: end)
//           .chain(CurveTween(curve: Curves.easeInOut));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }





//
// import 'package:flutter/material.dart';
//
// import 'Task 33 to 36_2.dart';
//
// /* ---------------- MAIN SCREEN ---------------- */
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   bool expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Animation Combo (Different)")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             /* 1️⃣ Fade-in Network Image (Slower Fade) */
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: FadeInImage(
//                 height: 160,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 placeholder: const AssetImage("assets/images/dhruv.jpg"),
//                 image: const NetworkImage(
//                   "https://picsum.photos/600/300",
//                 ),
//                 fadeInDuration: const Duration(seconds: 2),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /* 2️⃣ Expand / Collapse (Horizontal) */
//             ElevatedButton(
//               onPressed: () {
//                 setState(() => expanded = !expanded);
//               },
//               child: const Text("Toggle Panel"),
//             ),
//
//             const SizedBox(height: 10),
//
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.fastOutSlowIn,
//               height: 60,
//               width: expanded ? double.infinity : 0,
//               color: Colors.green.shade200,
//               alignment: Alignment.center,
//               child: expanded
//                   ? const Text(
//                 "Horizontal Expansion",
//                 style: TextStyle(fontSize: 16),
//               )
//                   : null,
//             ),
//
//             const SizedBox(height: 30),
//
//             /* 3️⃣ Auto Pulsing Button */
//             Center(
//               child: TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0.9, end: 1.1),
//                 duration: const Duration(milliseconds: 800),
//                 curve: Curves.easeInOut,
//                 builder: (context, scale, child) {
//                   return Transform.scale(
//                     scale: scale,
//                     child: child,
//                   );
//                 },
//                 onEnd: () => setState(() {}),
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: const Text("Auto Pulse"),
//                 ),
//               ),
//             ),
//
//             const Spacer(),
//
//             /* 4️⃣ Bottom-Up Slide + Fade Transition */
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, _bottomSlideRoute());
//                 },
//                 child: const Text("Next Screen"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// /* ---------------- CUSTOM ROUTE ---------------- */
//
// Route _bottomSlideRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (_, animation, __) => const NextScreen(),
//     transitionDuration: const Duration(milliseconds: 700),
//     transitionsBuilder: (_, animation, __, child) {
//       final slide = Tween(
//         begin: const Offset(0, 1),
//         end: Offset.zero,
//       ).animate(
//         CurvedAnimation(parent: animation, curve: Curves.easeOut),
//       );
//
//       final fade = Tween(begin: 0.0, end: 1.0).animate(animation);
//
//       return SlideTransition(
//         position: slide,
//         child: FadeTransition(opacity: fade, child: child),
//       );
//     },
//   );
// }
//
//
//
//
//
//
//
//
// // final code baki 6
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// /* ------------------- APP ------------------- */
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }
//
// /* ------------------- HOME SCREEN ------------------- */
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   bool expanded = false;
//   bool pulse = false;
//   bool replayImage = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("NEXT ALL Animations")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             /* 1️⃣ Fade + Scale Image (Tap to Replay) */
//             GestureDetector(
//               onTap: () {
//                 setState(() => replayImage = !replayImage);
//               },
//               child: Hero(
//                 tag: "hero-image",
//                 child: AnimatedScale(
//                   scale: replayImage ? 1.05 : 1.0,
//                   duration: const Duration(milliseconds: 600),
//                   curve: Curves.easeInOut,
//                   child: FadeInImage(
//                     height: 180,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     placeholder: const AssetImage("assets/placeholder.png"),
//                     image: const NetworkImage("https://picsum.photos/600/300"),
//                     fadeInDuration: const Duration(seconds: 1),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /* 2️⃣ Expandable Container */
//             ReusableExpandable(
//               expanded: expanded,
//               onToggle: () => setState(() => expanded = !expanded),
//               child: const Text(
//                 "This expandable container animates height, color, and content smoothly. Tap button to expand/collapse.",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /* 3️⃣ Pulsing + Glow Button */
//             ReusablePulseButton(
//               onTap: () {},
//               text: "Pulse + Glow Button",
//             ),
//
//             const Spacer(),
//
//             /* 4️⃣ Hero + Slide + Fade Navigation */
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(context, _heroSlideRoute());
//               },
//               child: const Text("Go To Next Screen"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /* ------------------- EXPANDABLE WIDGET ------------------- */
//
// class ReusableExpandable extends StatelessWidget {
//   final bool expanded;
//   final VoidCallback onToggle;
//   final Widget child;
//
//   const ReusableExpandable({
//     super.key,
//     required this.expanded,
//     required this.onToggle,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: onToggle,
//           child: Text(expanded ? "Collapse Panel" : "Expand Panel"),
//         ),
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOutCubic,
//           height: expanded ? 120 : 0,
//           width: double.infinity,
//           padding: const EdgeInsets.all(12),
//           margin: const EdgeInsets.only(top: 8),
//           decoration: BoxDecoration(
//             color: expanded ? Colors.orange.shade200 : Colors.orange.shade50,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: expanded ? child : null,
//         ),
//       ],
//     );
//   }
// }
//
// /* ------------------- PULSE + GLOW BUTTON ------------------- */
//
// class ReusablePulseButton extends StatefulWidget {
//   final VoidCallback onTap;
//   final String text;
//
//   const ReusablePulseButton({
//     super.key,
//     required this.onTap,
//     required this.text,
//   });
//
//   @override
//   State<ReusablePulseButton> createState() => _ReusablePulseButtonState();
// }
//
// class _ReusablePulseButtonState extends State<ReusablePulseButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnim;
//   late Animation<double> _glowAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat(reverse: true);
//
//     _scaleAnim = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//
//     _glowAnim = Tween<double>(begin: 2.0, end: 10.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
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
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) {
//         return Transform.scale(
//           scale: _scaleAnim.value,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               shadowColor: Colors.blue.withOpacity(0.5),
//               elevation: _glowAnim.value,
//             ),
//             onPressed: widget.onTap,
//             child: Text(widget.text),
//           ),
//         );
//       },
//     );
//   }
// }
//
// /* ------------------- NEXT SCREEN ------------------- */
//
// class NextScreen extends StatefulWidget {
//   const NextScreen({super.key});
//
//   @override
//   State<NextScreen> createState() => _NextScreenState();
// }
//
// class _NextScreenState extends State<NextScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Hero + Slide Screen")),
//       body: Center(
//         child: Hero(
//           tag: "hero-image",
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.network(
//               "https://picsum.photos/600/300",
//               width: 300,
//               height: 180,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /* ------------------- HERO + SLIDE ROUTE ------------------- */
//
// Route _heroSlideRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (_, __, ___) => const NextScreen(),
//     transitionDuration: const Duration(milliseconds: 700),
//     transitionsBuilder: (_, animation, __, child) {
//       final slide = Tween<Offset>(
//         begin: const Offset(0, 1),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
//
//       final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
//
//       return SlideTransition(
//         position: slide,
//         child: FadeTransition(opacity: fade, child: child),
//       );
//     },
//   );
// }
