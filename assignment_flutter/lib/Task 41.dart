import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;

  void _updateRating(int value) {
    setState(() {
      _rating = value;
    });
  }

  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        index <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 40,
      ),
      onPressed: () => _updateRating(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rating Widget')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return _buildStar(index + 1);
              }),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Rating: $_rating',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
