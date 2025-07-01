void main(List<String> args) {
  Set set = {1, 2, 35, 456.56, 'dart', false, 'hello user', 2354, 1};
  print(set);

  set.add(45);
  print(set);

  set.forEach((e) {
    print(e);
  });
}
