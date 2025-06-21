// Write a program that simulates a delayed operation using Future.delayed. Display a loading message, wait for 3 seconds, and then show a completion message.

import 'dart:async';

void main() {
  print('Starting operation...');
  print('Loading: [                    ] 0%');

  // Simulate a delayed operation
  simulateOperation().then((_) {
    print('\nOperation completed successfully!');
  });
}

Future<void> simulateOperation() async {
  // Show loading progress
  for (int i = 1; i <= 20; i++) {
    await Future.delayed(const Duration(milliseconds: 150));
    final progress = (i * 10);
    final bar = '[' + ('#' * i) + (' ' * (20 - i)) + ']';
    print('\rLoading: $bar $progress%');
  }

  // Final delay before completion
  await Future.delayed(const Duration(seconds: 1));
}
