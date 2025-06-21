// Implement a basic calculator that performs addition, subtraction, multiplication, or division based on the user’s choice.

import 'dart:io';

void main() {
  print("=== SIMPLE CALCULATOR ===");

  // Get first number
  print("Enter the first number:");
  double num1 = double.parse(stdin.readLineSync()!);

  // Get second number
  print("Enter the second number:");
  double num2 = double.parse(stdin.readLineSync()!);

  // Choose operation
  print("""
Select operation:
1 ➕ Add
2 ➖ Subtract 
3 ✖️ Multiply
4 ➗ Divide
""");
  int choice = int.parse(stdin.readLineSync()!);

  // Perform operation
  double result;
  switch (choice) {
    case 1:
      result = num1 + num2;
      print("Result: $num1 + $num2 = $result");
      break;
    case 2:
      result = num1 - num2;
      print("Result: $num1 - $num2 = $result");
      break;
    case 3:
      result = num1 * num2;
      print("Result: $num1 * $num2 = $result");
      break;
    case 4:
      if (num2 == 0) {
        print("Error: Division by zero!");
      } else {
        result = num1 / num2;
        print("Result: $num1 / $num2 = $result");
      }
      break;
    default:
      print("Invalid operation choice!");
  }
}
