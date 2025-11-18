import 'package:flutter/material.dart';

class CounterApp2 extends StatelessWidget {
  const CounterApp2({super.key});

  // A ValueNotifier holds the counter value
  static final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  // Function to increment counter
  void _incrementCounter() {
    _counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Stateless Counter App'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          // Rebuilds automatically when _counter changes
          child: ValueListenableBuilder<int>(
            valueListenable: _counter,
            builder: (context, value, _) {
              return Text(
                'Counter: $value',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      );
  }
}
