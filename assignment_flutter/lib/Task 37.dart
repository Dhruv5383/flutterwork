import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// PROVIDER CLASS
class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

/// ROOT APP
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}

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

/// WIDGET 2 – BUTTONS
class CounterButtons extends StatefulWidget {
  const CounterButtons({super.key});

  @override
  State<CounterButtons> createState() => _CounterButtonsState();
}

class _CounterButtonsState extends State<CounterButtons> {
  @override
  Widget build(BuildContext context) {
    final counter = context.read<CounterProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: counter.decrement,
          child: const Text("-"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: counter.increment,
          child: const Text("+"),
        ),
      ],
    );
  }
}
