class User {
  final String id;
  final String name;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String tel;
  final String intolerance;

  User({this.id, this.name, this.gender, this.age, this.weight, this.height, this.tel, this.intolerance});

  static fromJson(dynamic json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? null,
      weight: json['weight'] ?? null,
      height: json['height'] ?? null,
      tel: json['tel'] ?? '',
      intolerance: json['intolerance'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, gender: $gender, age: $age, weight: $weight, height: $height, tel: $tel, interolence: $intolerance}';
  }
}
