// Create a program that accepts a number from the user and performs division by another number. Use exception handling to manage division by zero errors.

import 'dart:io';

void main() {
  try {
    // Accept first number
    stdout.write("Enter the numerator: ");
    int numerator = int.parse(stdin.readLineSync()!);

    // Accept second number
    stdout.write("Enter the denominator: ");
    int denominator = int.parse(stdin.readLineSync()!);

    // Try to perform division
    double result = numerator / denominator;
    print("Result: $result");
  } on FormatException {
    print("Invalid input! Please enter numeric values only.");
  } on IntegerDivisionByZeroException {
    print("Error: Cannot divide by zero.");
  } catch (e) {
    print("An unexpected error occurred: $e");
  }
}
