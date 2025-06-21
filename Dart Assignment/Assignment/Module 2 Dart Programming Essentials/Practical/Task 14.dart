// Create a program that takes a list of words and removes any duplicates. Use a set to eliminate duplicates, then display the unique words in alphabetical order.

import 'dart:io';

void main() {
  print('Enter words separated by spaces:');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('No input provided!');
    return;
  }

  // Split input into words and convert to set to remove duplicates
  List<String> words = input.split(' ');
  Set<String> uniqueWords = words.toSet();

  // Convert back to list and sort alphabetically
  List<String> sortedUniqueWords = uniqueWords.toList()..sort();

  print('\nOriginal words: $words');
  print('Unique words: $uniqueWords');
  print('Alphabetically sorted unique words: $sortedUniqueWords');
}
