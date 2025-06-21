// Write a program to take a number from the user and determine if it’s even or odd.
import 'dart:io';

void main() {
  print('EVEN or ODD Checker');
  stdout.write('Enter a number: ');

  final num = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
  final result = num % 2 == 0 ? 'EVEN' : 'ODD';

  print('$num is $result');
}
