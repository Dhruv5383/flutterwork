// Write a program that uses async* to create a stream of integers. Display each integer as it’s emitted and stop the stream after a certain count.

import 'dart:async';

Stream<int> generateIntegers(int count) async* {
  for (int i = 0; i < count; i++) {
    await Future.delayed(Duration(seconds: 1)); // Simulate some delay
    yield i; // Emit the integer
  }
}

void main() async {
  int count = 5; // Specify the count of integers to emit
  Stream<int> integerStream = generateIntegers(count);

  await for (int value in integerStream) {
    print('Emitted: $value');
  }

  print('Stream completed.');
}
