// import 'package:flutter/material.dart';
//
// class NetworkImageApp extends StatefulWidget {
//   const NetworkImageApp({super.key});
//
//   @override
//   State<NetworkImageApp> createState() => _NetworkImageAppState();
// }
//
// class _NetworkImageAppState extends State<NetworkImageApp> {
//   // Two different image URLs
//   String imageUrl1 =
//       'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d';
//   String imageUrl2 =
//       'https://images.unsplash.com/photo-1506744038136-46273834b3fb';
//
//   // Current image being displayed
//   late String currentImage;
//
//   @override
//   void initState() {
//     super.initState();
//     currentImage = imageUrl1; // Default image
//   }
//
//   // Function to toggle between images
//   void changeImage() {
//     setState(() {
//       currentImage = (currentImage == imageUrl1) ? imageUrl2 : imageUrl1;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Network Image Switcher'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(
//               currentImage,
//               height: 250,
//               width: 300,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: changeImage,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//               child: const Text(
//                 'Change Image',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class LocalImageApp extends StatefulWidget {
  const LocalImageApp({super.key});

  @override
  State<LocalImageApp> createState() => _LocalImageAppState();
}

class _LocalImageAppState extends State<LocalImageApp> {
  // Local image paths
  String imagePath1 = 'assets/images/images1.png';
  String imagePath2 = 'assets/images/images2.png';

  late String currentImage;

  @override
  void initState() {
    super.initState();
    currentImage = imagePath1; // Start with first image
  }

  void changeImage() {
    setState(() {
      currentImage = (currentImage == imagePath1) ? imagePath2 : imagePath1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Image Switcher'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              currentImage,
              height: 300,
              width: 500,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: changeImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Change Image',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// class LocalImageStateless extends StatelessWidget {
//   const LocalImageStateless({super.key});
//
//   final String imagePath = 'assets/images/images1.png'; // fixed image path
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Local Image (Stateless)'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               imagePath,
//               height: 250,
//               width: 300,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 print("Button pressed — cannot change image in StatelessWidget");
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//               child: const Text(
//                 'Change Image',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
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
// class LocalImageNotifierApp extends StatelessWidget {
//   const LocalImageNotifierApp({super.key});
//
//   static final ValueNotifier<String> currentImage =
//   ValueNotifier<String>('assets/images/image1.jpg');
//
//   void changeImage() {
//     currentImage.value =
//     (currentImage.value == 'assets/images/image1.jpg')
//         ? 'assets/images/images2.png'
//         : 'assets/images/images1.png';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Local Image Switcher (Stateless + Notifier)'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ValueListenableBuilder<String>(
//               valueListenable: currentImage,
//               builder: (context, imagePath, _) {
//                 return Image.asset(
//                   imagePath,
//                   height: 250,
//                   width: 300,
//                   fit: BoxFit.cover,
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: changeImage,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//               child: const Text(
//                 'Change Image',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
