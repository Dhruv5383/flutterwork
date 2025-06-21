// Write a program that accepts a number and checks if it is a prime number or not.
import 'dart:io';

void main() {
  // Prompt the user to enter a number
  print('Enter a number:');
  String? input = stdin.readLineSync();

  // Check if the input is not null and can be parsed to an integer
  if (input != null) {
    int number = int.parse(input);

    // Check if the number is prime
    if (isPrime(number)) {
      print('$number is a prime number.');
    } else {
      print('$number is not a prime number.');
    }
  } else {
    print('Invalid input. Please enter a valid number.');
  }
}

// Function to check if a number is prime
bool isPrime(int n) {
  if (n <= 1) return false; // 0 and 1 are not prime numbers
  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) {
      return false; // Found a divisor, not prime
    }
  }
  return true; // No divisors found, it is prime
}
