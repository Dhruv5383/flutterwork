import 'dart:io';

void main(List<String> args) {
  try {
    print('enter a = ');
    int a = int.parse(stdin.readLineSync()!);
    ('enter b = ');
    int b = int.parse(stdin.readLineSync()!);
    int c = a ~/ b;
    print('c = $c');
  }
  //Exception
  catch (e) {
    print(e);
  }
  // on IntegerDivisionByZeroException{
  //   print('number cannot divide by 0');
  // }
  // on FormatException{
  //   print('denominator should be numeric value');
  // }
  finally {
    print('this will executes evrytime');
  }
}
