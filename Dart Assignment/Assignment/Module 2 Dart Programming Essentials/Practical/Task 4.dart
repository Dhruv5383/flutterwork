// Create a program that calculates the area and circumference of a circle. Use constants to store the value of pi.
import 'dart:io';

void main() {
  // Constant for pi
  const double pi = 3.14159;

  print('Circle Calculator');
  stdout.write('Enter the radius of the circle: ');

  // Read input and convert to double
  final input = stdin.readLineSync();
  final radius = double.tryParse(input ?? '') ?? 0.0;

  // Calculate area and circumference
  final area = pi * radius * radius; // Instead of pow(radius, 2)
  final circumference = 2 * pi * radius;

  // Print results with 2 decimal places
  print('\nResults:');
  print('Area: ${area.toStringAsFixed(2)}');
  print('Circumference: ${circumference.toStringAsFixed(2)}');
}
