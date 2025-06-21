// Create a program that converts temperature from Celsius to Fahrenheit and vice versa. Implement functions to handle both conversions and let the user choose the conversion type.
import 'dart:io';

// Simple Temperature Converter
void main() {
  print('Temperature Converter\n');

  while (true) {
    print('1. Celsius to Fahrenheit');
    print('2. Fahrenheit to Celsius');
    print('3. Exit');
    stdout.write('\nChoose an option (1-3): ');

    final choice = stdin.readLineSync();

    if (choice == '1') {
      convertCelsiusToFahrenheit();
    } else if (choice == '2') {
      convertFahrenheitToCelsius();
    } else if (choice == '3') {
      print('Goodbye!');
      break;
    } else {
      print('Invalid choice. Try again.');
    }
  }
}

void convertCelsiusToFahrenheit() {
  stdout.write('Enter Celsius: ');
  final celsius = double.tryParse(stdin.readLineSync() ?? '0');

  if (celsius == null) {
    print('Invalid number');
    return;
  }

  final fahrenheit = (celsius * 9 / 5) + 32;
  print('$celsius°C = ${fahrenheit.toStringAsFixed(1)}°F\n');
}

void convertFahrenheitToCelsius() {
  stdout.write('Enter Fahrenheit: ');
  final fahrenheit = double.tryParse(stdin.readLineSync() ?? '0');

  if (fahrenheit == null) {
    print('Invalid number');
    return;
  }

  final celsius = (fahrenheit - 32) * 5 / 9;
  print('$fahrenheit°F = ${celsius.toStringAsFixed(1)}°C\n');
}
