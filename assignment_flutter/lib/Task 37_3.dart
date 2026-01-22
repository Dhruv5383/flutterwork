// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import 'Task 37.dart';
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
