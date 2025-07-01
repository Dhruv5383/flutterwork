void main(List<String> args) {
  List list = [1, 'dart', 345.54, false, 3467676, 454.435, 1];

  print(list);

  list.add(34543);
  print(list);

  list.remove(false);

  print(list);

  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }

  list.forEach((element) {
    print(element);
  });

  List list1 = [435, 567.565, 'java', list];
  print(list1);

  list1.forEach((element) {
    print(element);
  });
}
