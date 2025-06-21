// Create a function that accepts a list of numbers and returns the largest and smallest
//numbers in the list.
import 'dart:io';

void findMinMax(List<num> numbers) {
  if (numbers.isEmpty) {
    print("The list is empty!");
    return;
  }

  num min = numbers[0];
  num max = numbers[0];

  for (num n in numbers) {
    if (n < min) min = n;
    if (n > max) max = n;
  }

  print("Smallest number: $min");
  print("Largest number: $max");
}

void main() {
  // Example 1: Hardcoded list
  List<num> numbers = [5, 2, 9, 1, 5, 6];
  findMinMax(numbers);

  // Example 2: User input
  print("\nEnter numbers separated by spaces:");
  String? input = stdin.readLineSync();

  if (input != null && input.isNotEmpty) {
    List<num> userNumbers = input.split(' ').map((e) => num.parse(e)).toList();
    findMinMax(userNumbers);
  } else {
    print("No numbers entered!");
  }
}
