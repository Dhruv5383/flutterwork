import 'dart:io';

void main(List<String> args) {
  for (int i = 1; i <= 5; i++) {
    for (int j = 1; j <= 7; j++) {
      stdout.write('*');
    }
    print('');
  }

  for (int i = 1; i <= 5; i++) {
    for (int j = 1; j <= i; j++) {
      stdout.write('*');
    }
    print('');
  }

  for (int i = 1; i <= 5; i++) {
    for (int k = 4; k >= i; k--) {
      stdout.write(' ');
    }
    for (int j = 1; j <= i; j++) {
      stdout.write('*');
    }
    print('');
  }

  for (int i = 1; i <= 5; i++) {
    //row
    for (int j = 1; j <= i; j++) {
      //col
      stdout.write('$i');
    }
    print('');
  }

  int counter = 1;
  for (int i = 1; i <= 5; i++) {
    //row
    for (int j = 1; j <= i; j++) {
      //col
      stdout.write('$counter ');
      counter++;
    }
    print('');
  }
}
