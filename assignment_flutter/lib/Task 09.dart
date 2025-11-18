// import 'package:flutter/material.dart';
//
// class SimpleCalculator extends StatelessWidget {
//   const SimpleCalculator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Helper function to create buttons
//     Widget calcButton(String text, Color color) {
//       return Expanded(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: color,
//               padding: const EdgeInsets.symmetric(vertical: 20),
//             ),
//             onPressed: () {
//               // Button press logic (you can add functionality later)
//               print('$text pressed');
//             },
//             child: Text(
//               text,
//               style: const TextStyle(fontSize: 22, color: Colors.white),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Simple Calculator'),
//           backgroundColor: Colors.blueAccent,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             // Display area
//             Container(
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: const Text(
//                 '0',
//                 style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Divider(thickness: 2),
//             // Buttons
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     calcButton('7', Colors.grey),
//                     calcButton('8', Colors.grey),
//                     calcButton('9', Colors.grey),
//                     calcButton('/', Colors.orange),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     calcButton('4', Colors.grey),
//                     calcButton('5', Colors.grey),
//                     calcButton('6', Colors.grey),
//                     calcButton('*', Colors.orange),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     calcButton('1', Colors.grey),
//                     calcButton('2', Colors.grey),
//                     calcButton('3', Colors.grey),
//                     calcButton('-', Colors.orange),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     calcButton('0', Colors.grey),
//                     calcButton('.', Colors.grey),
//                     calcButton('=', Colors.orange),
//                     calcButton('+', Colors.orange),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//   }
// }


// import 'package:flutter/material.dart';
//
// class SimpleCalculator extends StatelessWidget {
//   const SimpleCalculator({super.key});
//
//   Widget calcButton(String text, Color color) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color,
//             padding: const EdgeInsets.symmetric(vertical: 22),
//           ),
//           onPressed: () {
//             print('$text pressed'); // Just prints button name
//           },
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 22, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Simple Calculator'),
//           backgroundColor: Colors.blueAccent,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             // Display Area
//             Container(
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: const Text(
//                 '0',
//                 style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const Divider(thickness: 2),
//
//             // Calculator Buttons
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     calcButton('7', Colors.grey),
//                     calcButton('8', Colors.grey),
//                     calcButton('9', Colors.grey),
//                     calcButton('/', Colors.orange),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     calcButton('4', Colors.grey),
//                     calcButton('5', Colors.grey),
//                     calcButton('6', Colors.grey),
//                     calcButton('*', Colors.orange),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     calcButton('1', Colors.grey),
//                     calcButton('2', Colors.grey),
//                     calcButton('3', Colors.grey),
//                     calcButton('-', Colors.orange),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     calcButton('C', Colors.redAccent),
//                     calcButton('0', Colors.grey),
//                     calcButton('=', Colors.green),
//                     calcButton('+', Colors.orange),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//   }
// }


import 'package:flutter/material.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String display = '0';
  String operand = '';
  double num1 = 0;
  double num2 = 0;

  void buttonPressed(String text) {
    setState(() {
      if (text == 'C') {
        display = '0';
        num1 = 0;
        num2 = 0;
        operand = '';
      } else if (text == '+' || text == '-' || text == '*' || text == '/') {
        num1 = double.tryParse(display) ?? 0;
        operand = text;
        display = '0';
      } else if (text == '=') {
        num2 = double.tryParse(display) ?? 0;
        switch (operand) {
          case '+':
            display = (num1 + num2).toString();
            break;
          case '-':
            display = (num1 - num2).toString();
            break;
          case '*':
            display = (num1 * num2).toString();
            break;
          case '/':
            display = num2 != 0 ? (num1 / num2).toString() : 'Error';
            break;
        }
        operand = '';
      } else {
        if (display == '0') {
          display = text;
        } else {
          display += text;
        }
      }
    });
  }

  Widget calcButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 22),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display Area
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Text(
              display,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(thickness: 2),

          // Calculator Buttons
          Column(
            children: [
              Row(
                children: [
                  calcButton('7', Colors.grey),
                  calcButton('8', Colors.grey),
                  calcButton('9', Colors.grey),
                  calcButton('/', Colors.orange),
                ],
              ),
              Row(
                children: [
                  calcButton('4', Colors.grey),
                  calcButton('5', Colors.grey),
                  calcButton('6', Colors.grey),
                  calcButton('*', Colors.orange),
                ],
              ),
              Row(
                children: [
                  calcButton('1', Colors.grey),
                  calcButton('2', Colors.grey),
                  calcButton('3', Colors.grey),
                  calcButton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  calcButton('C', Colors.redAccent),
                  calcButton('0', Colors.grey),
                  calcButton('=', Colors.green),
                  calcButton('+', Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
