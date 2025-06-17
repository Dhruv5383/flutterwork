class Parent {
  void call() {
    print('call in parent class');
  }

  void run() {
    print('run in parent class');
  }
}

class Child extends Parent {
  void call() {
    super.call();
    print('call in child class');
  }

  void run() {
    print('run in child class');
  }
}

void main(List<String> args) {
  Child c = new Child();
  c.call();
  c.run();
}
