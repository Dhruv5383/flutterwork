void main(List<String> args) {
  int a = 12;
  int b = 32;
  //arithmetic
  print('a + b  = ${a + b}');
  print(a - b);
  print(a * b);
  print(a / b);
  print(a % b);

  //conditional
  print(a > b);
  print(a >= b);
  print(a < b);
  print(a <= b);
  print(a == b);
  print(a != b);

  //unary -> ++,--
  a++; // a = a+1 (post increment)
  print(a); //13

  a--; // a = a-1
  print(a); //12

  ++a; //(pre incremnet)
  print(a); //13

  --a;
  print(a); //12

  int c = a++;
  print('c = $c');

  //logical -> &&,||,!
}
