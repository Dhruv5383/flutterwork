void main(List<String> args) {
  Map map = {
    1: 'c',
    2: 'c', //entry
    3: 'c',
    'dart': 4,
    false: 'php',
    null: 'kotlin',
  };

  print(map);

  map.forEach((key, value) {
    print('key : $key value : $value');
  });
}
