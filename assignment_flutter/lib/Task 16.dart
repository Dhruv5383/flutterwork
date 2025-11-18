// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class ImageCarouselApp extends StatelessWidget {
//   const ImageCarouselApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ImageCarousel(),
//     );
//   }
// }
//
// class ImageCarousel extends StatefulWidget {
//   const ImageCarousel({super.key});
//
//   @override
//   State<ImageCarousel> createState() => _ImageCarouselState();
// }
//
// class _ImageCarouselState extends State<ImageCarousel> {
//   final PageController _pageController = PageController();
//   final List<String> _images = [
//     'assets/images/img1.jpg',
//     'assets/images/img2.jpg',
//     'assets/images/img3.jpg',
//     'assets/images/img4.jpg',
//   ];
//
//   int _currentPage = 0;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Auto-slide every 3 seconds
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < _images.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Image Carousel (Assets)"),
//         backgroundColor: Colors.teal,
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: _images.length,
//         itemBuilder: (context, index) {
//           return Image.asset(
//             _images[index],
//             fit: BoxFit.cover,
//             width: double.infinity,
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
//
// class ImageCarouselApp extends StatelessWidget {
//   const ImageCarouselApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ImageCarousel(),
//     );
//   }
// }
//
// class ImageCarousel extends StatelessWidget {
//   const ImageCarousel({super.key});
//
//   final List<String> _images = const [
//     'img_1.png',
//     'img_2.png',
//     'img_3.png',
//     'img_4.png',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Carousel (Assets - Stateless)'),
//         backgroundColor: Colors.teal,
//       ),
//       body: StreamBuilder<int>(
//         // Emit a new index every 3 seconds
//         stream: Stream.periodic(const Duration(seconds: 3), (count) => count),
//         builder: (context, snapshot) {
//           final index = snapshot.data ?? 0;
//           final currentImage = _images[index % _images.length];
//
//           return AnimatedSwitcher(
//             duration: const Duration(milliseconds: 600),
//             child: Image.asset(
//               currentImage,
//               key: ValueKey(currentImage),
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  final List<String> _images = [
    'assets/images/img_1.png',
    'assets/images/img_2.png',
    'assets/images/img_3.png',
    'assets/images/img_4.png',
  ];

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Auto-slide every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Carousel'),
        backgroundColor: Colors.teal,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Image.asset(
            _images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      ),
    );
  }
}

//normal code
// import 'dart:async';
// import 'package:flutter/material.dart';
//
// void main() => runApp(const ImageCarousel());
//
// class ImageCarousel extends StatefulWidget {
//   const ImageCarousel({super.key});
//
//   @override
//   State<ImageCarousel> createState() => _ImageCarouselState();
// }
//
// class _ImageCarouselState extends State<ImageCarousel> {
//   final PageController _pageController = PageController();
//   final List<String> _images = [
//     'assets/images/img1.jpg',
//     'assets/images/img2.jpg',
//     'assets/images/img3.jpg',
//     'assets/images/img4.jpg',
//   ];
//
//   int _currentPage = 0;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Auto-slide every 3 seconds
//     _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < _images.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Image Carousel'),
//           backgroundColor: Colors.teal,
//         ),
//         body: PageView.builder(
//           controller: _pageController,
//           itemCount: _images.length,
//           itemBuilder: (context, index) {
//             return Image.asset(
//               _images[index],
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
