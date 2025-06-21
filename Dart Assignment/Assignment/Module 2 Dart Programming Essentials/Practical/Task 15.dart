// Write a program that counts the frequency of each character in a given string and stores the result in a map.
import 'dart:io';

void main() {
  print('Enter a string:');
  String? input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print('No input provided!');
    return;
  }

  // Call the function to count character frequency
  countCharacterFrequency(input);
}

void countCharacterFrequency(String str) {
  Map<String, int> frequency = {};

  for (int i = 0; i < str.length; i++) {
    String char = str[i];
    // Increment the count for the character
    if (frequency.containsKey(char)) {
      frequency[char] = frequency[char]! + 1;
    } else {
      frequency[char] = 1;
    }
  }

  // Display the result
  print('\nCharacter frequency:');
  frequency.forEach((char, count) {
    print('$char: $count');
  });
}
