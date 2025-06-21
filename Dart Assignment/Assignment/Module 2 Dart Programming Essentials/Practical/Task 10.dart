// Create a function that checks if a string is a palindrome (reads the same backward as forward).

import 'dart:io';

bool isPalindrome(String str) {
  // Convert the string to lowercase and remove non-alphanumeric characters
  String cleanedStr = str.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

  // Check if the cleaned string is the same as its reverse
  return cleanedStr == cleanedStr.split('').reversed.join('');
}

void main() {
  // Prompt the user to enter a string
  print('Enter a string to check if it is a palindrome:');
  String? input = stdin.readLineSync();

  if (input != null) {
    if (isPalindrome(input)) {
      print('"$input" is a palindrome!');
    } else {
      print('"$input" is not a palindrome.');
    }
  } else {
    print('Invalid input.');
  }
}
