// Write a program to input a list of integers and sort them in ascending and descending order without using built-in sort methods.
import 'dart:io';

void main() {
  print('Enter integers separated by spaces:');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('No input provided!');
    return;
  }

  try {
    List<int> numbers = input.split(' ').map((e) => int.parse(e)).toList();

    // Sort in ascending order (using bubble sort)
    List<int> ascending = List.from(numbers);
    bubbleSort(ascending);

    // Sort in descending order (using modified bubble sort)
    List<int> descending = List.from(ascending.reversed);

    print('\nOriginal list: $numbers');
    print('Ascending order: $ascending');
    print('Descending order: $descending');
  } catch (e) {
    print('Invalid input! Please enter integers only.');
  }
}

// Bubble sort implementation for ascending order
void bubbleSort(List<int> list) {
  int n = list.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        // Swap elements
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
}
