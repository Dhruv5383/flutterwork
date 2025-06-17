import 'dart:io';

void main(List<String> args) {
  print("hello dart");
  print("dhruv patel");
  stdout.write("hello \n");
  stdout.write("hello dart 23\n");

  print("enter a = ");
  int a = int.parse(stdin.readLineSync()!);

  print("enter b = ");
  int b = int.parse(stdin.readLineSync()!);

  print('a + b = ${a + b}');

  print("enter double value =");
  double d = double.parse(stdin.readLineSync()!);
  print(d);
}
