// Write a program that reads a file and displays its contents. Handle potential file not found exceptions and display an error message if the file doesn’t exist.

import 'dart:io';

void main() {
  stdout.write("Enter file path: ");
  String? filePath = stdin.readLineSync();

  try {
    File file = File(filePath!);
    String contents = file.readAsStringSync();
    print("\n--- File Contents ---");
    print(contents);
  } on FileSystemException {
    print("Error: File not found or cannot be opened.");
  } catch (e) {
    print("An unexpected error occurred: $e");
  }
}
