class Data {
  int? a;
  String? name;
  double? value;
  bool? res;

  Data(int a, String name, double value, bool res) {
    this.a = a;
    this.name = name;
    this.value = value;
    this.res = res;
    print('cons output :  a = $a, name = $name, value = $value, res = $res');
  }

  void showData() {
    print('fun outpur : a = $a, name = $name, value = $value, res = $res');
  }
}

void main(List<String> args) {
  Data d = new Data(14, 'dart', 56.4565, true);
  d.showData();
}
