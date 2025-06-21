// Write a program that takes a user's name and age as input and prints a welcome message that includes their name and how many years they have left until they turn 100.
import 'dart:io';

void main() {
  // Get user input for name
  stdout.write('Please enter your name: ');
  String name = stdin.readLineSync()!;

  // Get user input for age
  stdout.write('Please enter your age: ');
  int age = int.parse(stdin.readLineSync()!);

  // Calculate years left until 100
  int yearsLeft = 100 - age;

  // Print the welcome message
  print('Welcome, $name! You have $yearsLeft years left until you turn 100.');
}
