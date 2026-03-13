import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: ProgressDemoScreen(),
//     );
//   }
// }

class ProgressDemoScreen extends StatefulWidget {
  const ProgressDemoScreen({super.key});

  @override
  State<ProgressDemoScreen> createState() => _ProgressDemoScreenState();
}

class _ProgressDemoScreenState extends State<ProgressDemoScreen> {
  double progress = 30; // percentage (0–100)

  void increaseProgress() {
    setState(() {
      if (progress < 100) {
        progress += 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Progress Bar')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomProgressBar(percentage: progress),
            const SizedBox(height: 20),
            Text(
              '${progress.toInt()}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: increaseProgress,
              child: const Text('Increase Progress'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatefulWidget {
  final double percentage;

  const CustomProgressBar({super.key, required this.percentage});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: constraints.maxWidth * (widget.percentage / 100),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
