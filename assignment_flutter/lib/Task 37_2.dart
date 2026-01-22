import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Task 37.dart';

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
//
// /// WIDGET 2 – BUTTONS
// class CounterButtons extends StatefulWidget {
//   const CounterButtons({super.key});
//
//   @override
//   State<CounterButtons> createState() => _CounterButtonsState();
// }
//
// class _CounterButtonsState extends State<CounterButtons> {
//   @override
//   Widget build(BuildContext context) {
//     final counter = context.read<CounterProvider>();
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: counter.decrement,
//           child: const Text("-"),
//         ),
//         const SizedBox(width: 20),
//         ElevatedButton(
//           onPressed: counter.increment,
//           child: const Text("+"),
//         ),
//       ],
//     );
//   }
// }
