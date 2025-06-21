// Write a function to calculate the factorial of a number entered by the user.
import 'dart:io';

void main() {
  // Prompt the user to enter a number
  print('Enter a number to calculate its factorial:');
  String? input = stdin.readLineSync();

  // Check if the input is not null and can be parsed to an integer
  if (input != null) {
    int number = int.parse(input);

    // Calculate the factorial
    int result = factorial(number);

    // Print the result
    print('The factorial of $number is $result.');
  } else {
    print('Invalid input. Please enter a valid number.');
  }
}

// Function to calculate the factorial of a number
int factorial(int n) {
  if (n < 0) {
    throw ArgumentError('Factorial is not defined for negative numbers.');
  }
  if (n == 0 || n == 1) {
    return 1; // Base case: 0! = 1 and 1! = 1
  }
  return n * factorial(n - 1); // Recursive case
}
