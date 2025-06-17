//withuot return type without para
import 'dart:io';

void call() {
  print('call function');
}

//withuot return type with para
void run(int i, String name) {
  print('i = $i name = $name');
}

//with return type without para
String? show() {
  return 'dart';
}

//with return type with para
int? square(int num) {
  return num * num;
}

void main(List<String> args) {
  print('hello');

  call();

  run(12, 'dart');

  String? name = show();
  print('name  = $name');

  print('enter num to get square : ');
  int num = int.parse(stdin.readLineSync()!);

  int? res = square(num);
  print('res = $res');
}
