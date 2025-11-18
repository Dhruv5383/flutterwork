// ---------------- DETAILS SCREEN ----------------
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String data;
  const DetailsScreen({super.key, required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Screen"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          "Received: ${widget.data}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
