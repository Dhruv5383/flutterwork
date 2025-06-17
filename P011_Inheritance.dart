//single
class A {
  A() {
    print('A class Constructor');
  }
  void classA() {
    print('class A fun');
  }
}

class B extends A {
  void classB() {
    print('class B fun');
  }
}

//multilevel
class C extends B {
  void classC() {
    print('class C fun');
  }
}

//hierarchical
class D extends A {
  void classD() {
    print('class D fun');
  }
}

class E extends A {
  void classE() {
    print('class E fun');
  }
}

void main(List<String> args) {
  A a = new A();
  a.classA();

  B b = new B();
  b.classA();
  b.classB();

  C c = new C();
  c.classA();
  c.classB();
  c.classC();

  D d = new D();
  d.classA();
  d.classD();

  E e = new E();
  e.classA();
  e.classE();
}
