class User {
  int? id;
  String? name;

  User() {
    print('defualt');
  }

  User.para(int id, String name) {
    this.id = id;
    this.name = name;
  }

  void setId(int id) {
    this.id = id;
  }

  void setName(String name) {
    this.name = name;
  }

  int? getId() {
    return id;
  }

  String? getName() {
    return name;
  }

  @override
  String toString() {
    return 'id : $id name : $name';
  }
}

void main(List<String> args) {
  User u = new User();
  u.setId(12);
  print(u.getId());
  u.setName('dart');
  print(u.getName());

  User u1 = new User.para(12, 'dhruv');
  print(u1.getId());
  print(u1.getName());

  print(u1);
}
