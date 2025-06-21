// Implement a basic file reading and writing program using the dart:io library. Write data to a file and read it back, handling any file errors that may occur.

import 'dart:io';

void main() async {
  // File path
  const filePath = 'example.txt';

  try {
    // Write to file
    await writeFile(filePath, 'Hello, Dart File I/O!\nThis is a second line.');
    print('Successfully wrote to file.');

    // Read from file
    String content = await readFile(filePath);
    print('\nFile content:');
    print(content);
  } on FileSystemException catch (e) {
    print('File system error: ${e.message}');
  } catch (e) {
    print('An error occurred: $e');
  }
}

Future<void> writeFile(String path, String content) async {
  try {
    final file = File(path);
    await file.writeAsString(content);
  } on FileSystemException catch (e) {
    throw FileSystemException('Could not write to file: ${e.message}');
  }
}

Future<String> readFile(String path) async {
  try {
    final file = File(path);
    if (!await file.exists()) {
      throw FileSystemException('File does not exist');
    }
    return await file.readAsString();
  } on FileSystemException catch (e) {
    throw FileSystemException('Could not read file: ${e.message}');
  }
}
