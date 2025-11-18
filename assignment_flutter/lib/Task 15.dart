import 'package:flutter/material.dart';

class MyListview2 extends StatelessWidget {
  const MyListview2({super.key});

  @override
  Widget build(BuildContext context) {

    var images =[
      'img_1.png',
      'img_2.png',
      'img_3.png',
      'img_4.png',
      'img_5.png',
      'img_6.jpg',
      'img.png'
    ];


    return Scaffold(
      appBar: AppBar(title: Text('ListView2'), backgroundColor: Colors.grey),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(itemBuilder: (context, index) {
          return Image.asset('assets/images/${images[index]}');
        },
          itemCount: images.length,
          //scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class LocalImageBoxFitDemo extends StatelessWidget {
//   const LocalImageBoxFitDemo({super.key});
//
//   final String imagePath = 'assets/images/img_1.png';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Local Image BoxFit Demo'),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               'BoxFit.cover',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Container(
//               height: 200,
//               width: double.infinity,
//               margin: const EdgeInsets.all(10),
//               color: Colors.black12,
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const Text(
//               'BoxFit.contain',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Container(
//               height: 200,
//               width: double.infinity,
//               margin: const EdgeInsets.all(10),
//               color: Colors.black12,
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const Text(
//               'BoxFit.fill',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Container(
//               height: 200,
//               width: double.infinity,
//               margin: const EdgeInsets.all(10),
//               color: Colors.black12,
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//}



// import 'package:flutter/material.dart';
//
// class MultipleImageBoxFitDemo extends StatelessWidget {
//   const MultipleImageBoxFitDemo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> imagePaths = [
//       'assets/images/img_1.png',
//       'assets/images/img_2.png',
//       'assets/images/img_3.png',
//       'assets/images/img_4.png',
//       'assets/images/img_5.png',
//       'assets/images/img_6.png',
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Multiple Local Images (BoxFit Demo)'),
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             buildImageSection(imagePaths[0], 'BoxFit.cover', BoxFit.cover),
//             buildImageSection(imagePaths[1], 'BoxFit.contain', BoxFit.contain),
//             buildImageSection(imagePaths[2], 'BoxFit.fill', BoxFit.fill),
//             buildImageSection(imagePaths[0], 'BoxFit.fitWidth', BoxFit.fitWidth),
//             buildImageSection(imagePaths[1], 'BoxFit.fitHeight', BoxFit.fitHeight),
//             buildImageSection(imagePaths[2], 'BoxFit.none', BoxFit.none),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Reusable method for displaying image + label
//   Widget buildImageSection(String path, String label, BoxFit fit) {
//     return Column(
//       children: [
//         const SizedBox(height: 15),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 200,
//           width: double.infinity,
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           color: Colors.black12,
//           child: Image.asset(
//             path,
//             fit: fit,
//           ),
//         ),
//       ],
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
//
// class MyListTile1 extends StatelessWidget {
//   const MyListTile1 ({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List images = [
//       'img_1.png',
//       'img_2.png',
//       'img_6.jpg',
//     ];
//
//     return Scaffold(
//       appBar: AppBar(title: Text('LIstTile'), backgroundColor: Colors.blue),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: Container(
//               height: 100,
//               width: 100,
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/${images[index]}'),
//               ),
//             ),
//             title: Text(
//               '${images[index]}',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text('${images[index]}', style: TextStyle(fontSize: 20)),
//             trailing: Icon(Icons.add),
//           );
//         },
//         itemCount: images.length,
//       ),
//     );
//   }
// }