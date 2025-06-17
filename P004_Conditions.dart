import 'dart:io';

void main(List<String> args) {
  print('enter a = ');
  int a = int.parse(stdin.readLineSync()!);

  print('enter b = ');
  int b = int.parse(stdin.readLineSync()!);

  if (a > b) {
    print('a is greater than b');
  } else {
    print('b is greater than a');
  }

  //print("enter name? = ");
  //String? name = stdin.readLineSync()!;
  print('enter marks = ');
  int m = int.parse(stdin.readLineSync()!);

  if (m < 35) {
    print('fail');
  } else if (m >= 35 && m <= 50) {
    print('D grade');
  } else if (m >= 51 && m <= 70) {
    print('C grade');
  } else if (m >= 71 && m <= 80) {
    print('B grade');
  } else if (m >= 81 && m <= 90) {
    print('A grade');
  } else if (m >= 91 && m <= 100) {
    print('A+ grade');
  } else {
    print('invalid input');
  }

  print('enter age = ');
  int age = int.parse(stdin.readLineSync()!);

  if (age > 18) {
    if (age < 55) {
      print('you are eligible');
    } else {
      print('age is greater than 18 but not less tha 55');
    }
  } else {
    print('age is less than 18');
  }

  print('1.English 2.Hindi 3.Gujarati');
  print('enter choice  = ');
  int c = int.parse(stdin.readLineSync()!);
  switch (c) {
    case 1:
      print('you selected english');
      break;
    case 2:
      print('you selected hindi');
      break;
    case 3:
      print('you selected gujarati');
      break;
    default:
      print('invalind input');
  }
}
