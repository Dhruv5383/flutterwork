// Implement a simple number guessing game where the computer generates a random number, and the user has to guess it. Use a lambda function to provide hints, such as “too high” or “too low.”

import 'dart:io';
import 'dart:math';

void main() {
  Random random = Random();
  int targetNumber = random.nextInt(100) + 1; // Random number between 1 and 100
  int? userGuess;

  // Lambda function for providing hints
  String Function(int) provideHint = (int guess) {
    if (guess < targetNumber) {
      return "Too low!";
    } else if (guess > targetNumber) {
      return "Too high!";
    } else {
      return "Correct!";
    }
  };

  print("Welcome to the Number Guessing Game!");
  print("I have selected a number between 1 and 100. Try to guess it!");

  while (userGuess != targetNumber) {
    stdout.write("Enter your guess: ");
    String? input = stdin.readLineSync();

    if (input != null) {
      userGuess = int.tryParse(input);

      if (userGuess != null) {
        String hint = provideHint(userGuess);
        print(hint);
      } else {
        print("Please enter a valid number.");
      }
    }
  }

  print("Congratulations! You've guessed the number $targetNumber.");
}
