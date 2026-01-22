// import 'package:flutter/material.dart';
//
// class SecondScreen extends StatefulWidget {
//   const SecondScreen({super.key});
//
//   @override
//   State<SecondScreen> createState() => _SecondScreenState();
// }
//
// class _SecondScreenState extends State<SecondScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Screen')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Go Back'),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DetailsScreen36 extends StatefulWidget {
  const DetailsScreen36({super.key});

  @override
  State<DetailsScreen36> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen36> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back'),
        ),
      ),
    );
  }
}
