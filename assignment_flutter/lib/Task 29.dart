// import 'package:flutter/material.dart';
//
//
// class OverlayApp extends StatelessWidget {
//   const OverlayApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Background Image
//             const Image(
//               image: AssetImage('assets/images/watch.jpg'),
//               width: 300,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//
//             // Semi-transparent overlay
//             Container(
//               width: 300,
//               height: 200,
//               color: Colors.black54, // transparent overlay
//             ),
//
//             // Text on top
//             const Text(
//               'Overlay Text',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';


class OverlayApp extends StatelessWidget {
  const OverlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: OverlayCard(),
      ),
    );
  }
}

class OverlayCard extends StatefulWidget {
  const OverlayCard({super.key});

  @override
  State<OverlayCard> createState() => _OverlayCardState();
}

class _OverlayCardState extends State<OverlayCard> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Rounded image
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
            width: 320,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),

        // Gradient overlay
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 320,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),

        // Clickable text overlay
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            setState(() {
              clicked = !clicked;
            });
          },
          child: Container(
            width: 320,
            height: 200,
            alignment: Alignment.center,
            child: Text(
              clicked ? 'Clicked!' : 'Tap Me',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
