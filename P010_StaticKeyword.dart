class Student {
  static int a = 132;
  void call() {
    print('student call function : $a');
  }

  static void calling() {
    print('static calling : $a');
  }
}

void main(List<String> args) {
  Student s = new Student();
  s.call();
  Student.calling();
}
