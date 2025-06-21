// Write a recursive function to generate the Fibonacci series up to a specified number.
import 'dart:io';

List<int> fibonacci(int n) {
  List<int> series = [];
  for (int i = 0; i < n; i++) {
    series.add(fib(i));
  }
  return series;
}

int fib(int n) {
  if (n <= 1) {
    return n; // Base case: fib(0) = 0, fib(1) = 1
  }
  return fib(n - 1) + fib(n - 2); // Recursive case
}

void main() {
  print('Enter the number of Fibonacci terms to generate:');
  String? input = stdin.readLineSync();

  if (input != null) {
    int terms = int.parse(input);
    List<int> fibSeries = fibonacci(terms);
    print('Fibonacci series up to $terms terms: $fibSeries');
  } else {
    print('Invalid input.');
  }
}
