// import 'package:flutter/material.dart';
//
// class FadeInLocalImagePage extends StatefulWidget {
//   @override
//   _FadeInLocalImagePageState createState() => _FadeInLocalImagePageState();
// }
//
// class _FadeInLocalImagePageState extends State<FadeInLocalImagePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Fade-In Local Image'), centerTitle: true),
//       body: Center(
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: FadeInImage.asset(
//             placeholder: 'assets/placeholder.png',
//             image: 'assets/sample.jpg',
//             width: 250,
//             height: 250,
//             fit: BoxFit.cover,
//             fadeInDuration: Duration(seconds: 1),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//




// import 'package:flutter/material.dart';
//
// class FadeInAssetImagePage extends StatefulWidget {
//   @override
//   _FadeInAssetImagePageState createState() => _FadeInAssetImagePageState();
// }
//
// class _FadeInAssetImagePageState extends State<FadeInAssetImagePage> {
//   double _opacity = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Start fade-in after build
//     Future.delayed(Duration(milliseconds: 100), () {
//       setState(() {
//         _opacity = 1.0;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fade-In Asset Image'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: AnimatedOpacity(
//           opacity: _opacity,
//           duration: Duration(seconds: 1),
//           curve: Curves.easeInOut,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.asset(
//               'assets/images/img.png',
//               width: 250,
//               height: 250,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





//
//
// import 'package:flutter/material.dart';
//
// class Task_33 extends StatelessWidget {
//   const Task_33({Key? key}) : super(key: key);
//
//   get Shimmer => null;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F4F6),
//       appBar: AppBar(
//         title: const Text('Task 33 - Fade-In Image with Shimmer'),
//         backgroundColor: const Color(0xFF1F2937),
//         foregroundColor: Colors.white,
//         elevation: 2,
//       ),
//       body: Center(
//         child: Container(
//           width: 350,
//           height: 230,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 8,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: FadeInImage.assetNetwork(
//              placeholder: 'assets/images/dhruv.jpg',
//               image:
//               'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
//               fadeInDuration: const Duration(milliseconds: 700),
//               fit: BoxFit.cover,
//               placeholderErrorBuilder: (context, error, stackTrace) {
//                 return _buildShimmerPlaceholder();
//               },
//               imageErrorBuilder: (context, error, stackTrace) {
//                 return _buildShimmerPlaceholder();
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: const Color(0xFFE5E7EB),
//       highlightColor: const Color(0xFFF9FAFB),
//       child: Container(
//         color: const Color(0xFFE5E7EB),
//       ),
//     );
//   }
// }


//Shimmer.fromColors





// import 'package:flutter/material.dart';
//
// class FadeInAssetImagePage extends StatefulWidget {
//   @override
//   _FadeInAssetImagePageState createState() => _FadeInAssetImagePageState();
// }
//
// class _FadeInAssetImagePageState extends State<FadeInAssetImagePage> {
//   double _opacity = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Start fade-in after build
//     Future.delayed(Duration(milliseconds: 100), () {
//       setState(() {
//         _opacity = 1.0;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fade-In Asset Image'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: AnimatedOpacity(
//           opacity: _opacity,
//           duration: Duration(seconds: 1),
//           curve: Curves.easeInOut,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.asset(
//               'assets/images/watch.jpg',
//               width: 250,
//               height: 250,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//
//
// import 'package:flutter/material.dart';
//
// class AdvancedImageAnimationPage extends StatefulWidget {
//   @override
//   _AdvancedImageAnimationPageState createState() =>
//       _AdvancedImageAnimationPageState();
// }
//
// class _AdvancedImageAnimationPageState
//     extends State<AdvancedImageAnimationPage> {
//   List<double> _opacity = [0, 0, 0];
//   List<double> _scale = [0.8, 0.8, 0.8];
//   List<Offset> _offset = [
//     Offset(0, 0.3),
//     Offset(0, 0.3),
//     Offset(0, 0.3),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//   }
//
//   void _startAnimation() {
//     for (int i = 0; i < 3; i++) {
//       Future.delayed(Duration(milliseconds: 300 * i), () {
//         setState(() {
//           _opacity[i] = 1;
//           _scale[i] = 1;
//           _offset[i] = Offset.zero;
//         });
//       });
//     }
//   }
//
//   void _replayAnimation() {
//     setState(() {
//       _opacity = [0, 0, 0];
//       _scale = [0.8, 0.8, 0.8];
//       _offset = [
//         Offset(0, 0.3),
//         Offset(0, 0.3),
//         Offset(0, 0.3),
//       ];
//     });
//
//     _startAnimation();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fade • Scale • Slide'),
//         centerTitle: true,
//       ),
//       body: GestureDetector(
//         onTap: _replayAnimation,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(3, (index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: AnimatedSlide(
//                 offset: _offset[index],
//                 duration: Duration(milliseconds: 600),
//                 curve: Curves.easeOut,
//                 child: AnimatedScale(
//                   scale: _scale[index],
//                   duration: Duration(milliseconds: 600),
//                   curve: Curves.easeOutBack,
//                   child: AnimatedOpacity(
//                     opacity: _opacity[index],
//                     duration: Duration(milliseconds: 600),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(18),
//                       child: Image.asset(
//                         'assets/images/img_${index + 1}.jpg',
//                         width: 220,
//                         height: 140,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
