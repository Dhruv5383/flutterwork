import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

/// WIDGET 1 – DISPLAY COUNTER
class CounterText extends StatefulWidget {
  const CounterText({super.key});

  @override
  State<CounterText> createState() => _CounterTextState();
}

class _CounterTextState extends State<CounterText> {
  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterProvider>().count;

    return Text(
      "Counter Value: $count",
      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    );
  }
}
