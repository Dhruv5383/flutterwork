import 'dart:io';

class User {
  User() {
    print('default cons');
  }
  // User(){
  //   print('default cons');
  // }
  User.intCons(int a) {
    print('a = $a');
  }
  User.stringCons(String a) {
    print('a = $a');
  }
  User.data(int a, String name) {
    print('a = $a name = $name');
  }
  void showData() {
    print('user details');
  }
}

void main(List<String> args) {
  User u = new User();
  u.showData();

  print('enter number : ');
  int a = int.parse(stdin.readLineSync()!);
  User u1 = new User.intCons(a);

  User u2 = new User.stringCons('My name');
}
