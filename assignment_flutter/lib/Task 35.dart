// import 'package:flutter/material.dart';
//
//
//
// class PulseButton extends StatefulWidget {
//   const PulseButton({super.key});
//
//   @override
//   State<PulseButton> createState() => _PulseButtonState();
// }
//
// class _PulseButtonState extends State<PulseButton> {
//   bool isBig = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pulse Button')),
//       body: Center(
//         child: TweenAnimationBuilder<double>(
//           tween: Tween<double>(
//             begin: isBig ? 1.0 : 0.9,
//             end: isBig ? 0.9 : 1.0,
//           ),
//           duration: const Duration(milliseconds: 700),
//           curve: Curves.easeInOut,
//           onEnd: () {
//             setState(() {
//               isBig = !isBig;
//             });
//           },
//           builder: (context, scale, child) {
//             return Transform.scale(
//               scale: scale,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 16,
//                   ),
//                   child: Text(
//                     'PULSE',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';

import 'Task 35_2.dart';

class PulseDemo extends StatefulWidget {
  const PulseDemo({super.key});

  @override
  State<PulseDemo> createState() => _PulseDemoState();
}

class _PulseDemoState extends State<PulseDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Glow Pulse Button')),
      body: Center(
        child: GlowPulseButton(
          text: 'TAP ME',
          onTap: () {
            debugPrint('Button tapped');
          },
        ),
      ),
    );
  }
}
