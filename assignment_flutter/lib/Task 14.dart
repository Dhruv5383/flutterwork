// import 'package:flutter/material.dart';
//
// class MyGalleryApp extends StatelessWidget {
//   final List<String> imageUrls = [
//     'https://images.unsplash.com/photo-1500100586562-f75ff6540087?auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1523719185231-aff40a400361?auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
//     'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?auto=format&fit=crop&w=800&q=60',
//     'https://www.shutterstock.com/image-photo/waterfall-nechar-sky-260nw-1268179705.jpg',
//     // Add more image URLs as needed
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Photo Gallery'),backgroundColor: Colors.teal,),
//         body: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: GridView.builder(
//             gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 8,
//               mainAxisSpacing: 8,
//             ),
//             itemCount: imageUrls.length,
//             itemBuilder: (context, index) {
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   imageUrls[index],
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
//                             : null,
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Center(child: Icon(Icons.broken_image));
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//   }
// }




import 'package:flutter/material.dart';

class PhotoGalleryApp extends StatefulWidget {
  const PhotoGalleryApp({super.key});

  @override
  State<PhotoGalleryApp> createState() => _PhotoGalleryAppState();
}

class _PhotoGalleryAppState extends State<PhotoGalleryApp> {
  // List of image URLs
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    'https://images.unsplash.com/photo-1495567720989-cebdbdd97913',
    'https://images.unsplash.com/photo-1481277542470-605612bd2d61',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1504196606672-aef5c9cefc92',
    'https://images.unsplash.com/photo-1531746790731-6c087fecd65a',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child; // Loaded
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  ); // While loading
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ); // If failed to load
                },
              ),
            );
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class PhotoGalleryStateless extends StatelessWidget {
//   const PhotoGalleryStateless({super.key});
//
//   // List of image URLs
//   final List<String> imageUrls = const [
//     'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
//     'https://images.unsplash.com/photo-1495567720989-cebdbdd97913',
//     'https://images.unsplash.com/photo-1481277542470-605612bd2d61',
//     'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d',
//     'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
//     'https://images.unsplash.com/photo-1504196606672-aef5c9cefc92',
//     'https://images.unsplash.com/photo-1531746790731-6c087fecd65a',
//     'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
//     'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Photo Gallery'),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           itemCount: imageUrls.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // Number of columns
//             crossAxisSpacing: 8.0,
//             mainAxisSpacing: 8.0,
//           ),
//           itemBuilder: (context, index) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 imageUrls[index],
//                 fit: BoxFit.cover,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return const Center(
//                     child: CircularProgressIndicator(strokeWidth: 2.5),
//                   );
//                 },
//                 errorBuilder: (context, error, stackTrace) {
//                   return const Center(
//                     child: Icon(Icons.error, color: Colors.red),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
