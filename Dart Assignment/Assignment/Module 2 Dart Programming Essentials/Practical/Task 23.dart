// Implement a calculator that catches invalid input errors (like entering a string instead of a number). Display appropriate error messages and ask for re-entry.
import 'dart:io';

void main() {
  print('Simple Calculator\n');

  while (true) {
    print('1. Add (+)');
    print('2. Subtract (-)');
    print('3. Multiply (*)');
    print('4. Divide (/)');
    print('5. Exit');
    print('--------------------');

    // Get valid menu choice
    int choice = getMenuChoice();

    if (choice == 5) {
      print('Goodbye!');
      break;
    }

    // Get valid numbers
    double num1 = getNumber('Enter first number: ');
    double num2 = getNumber('Enter second number: ');

    // Perform calculation
    calculateAndShowResult(choice, num1, num2);

    print('\n' + '=' * 20 + '\n'); // Separator
  }
}

// Helper function to get valid menu choice
int getMenuChoice() {
  while (true) {
    stdout.write('Enter your choice (1-5): ');
    String? input = stdin.readLineSync();

    try {
      int choice = int.parse(input!);
      if (choice >= 1 && choice <= 5) {
        return choice;
      } else {
        print('Please enter a number between 1 and 5');
      }
    } catch (e) {
      print('Invalid input. Please enter a number between 1 and 5');
    }
  }
}

// Helper function to get numbers with validation
double getNumber(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    try {
      return double.parse(input!);
    } catch (e) {
      print('Invalid number. Please try again.');
    }
  }
}

// Helper function to perform calculations and show results
void calculateAndShowResult(int choice, double num1, double num2) {
  double result;
  String operation;

  switch (choice) {
    case 1:
      result = num1 + num2;
      operation = '+';
      break;
    case 2:
      result = num1 - num2;
      operation = '-';
      break;
    case 3:
      result = num1 * num2;
      operation = '*';
      break;
    case 4:
      if (num2 == 0) {
        print('Error: Cannot divide by zero');
        return;
      }
      result = num1 / num2;
      operation = '/';
      break;
    default:
      return;
  }

  print('\nResult: $num1 $operation $num2 = ${result.toStringAsFixed(2)}');
}
