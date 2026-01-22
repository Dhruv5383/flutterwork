import 'package:firebase_flutter_pro/task%2037_2.dart';
import 'package:firebase_flutter_pro/task%2037_3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';


/// MAIN SCREEN
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Counter App")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CounterText(),
          SizedBox(height: 20),
          CounterButtons(),
        ],
      ),
    );
  }
}
