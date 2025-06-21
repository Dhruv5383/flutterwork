// Create a program that accepts a list of integers from the user. Use exception handling to handle cases where the user inputs non-integer values.

import 'dart:io';

void main() {
  List<int> numbers = [];

  stdout.write("Enter how many numbers you want to input: ");
  int? count;

  try {
    count = int.parse(stdin.readLineSync()!);
  } catch (e) {
    print("Invalid input. Please enter an integer.");
    return;
  }

  for (int i = 0; i < count; i++) {
    stdout.write("Enter integer ${i + 1}: ");
    try {
      int number = int.parse(stdin.readLineSync()!);
      numbers.add(number);
    } catch (e) {
      print("Invalid input! Only integers are allowed.");
      i--; // retry the same input
    }
  }

  print("\nYou entered the following integers:");
  print(numbers);
}
