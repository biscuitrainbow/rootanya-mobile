class User {
  final String email;
  final String password;
  final String id;
  final String name;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String tel;
  final String intolerance;
  final String disease;
  final String medicine;
  final String token;

  User({
    this.email,
    this.password,
    this.id,
    this.name,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.tel,
    this.intolerance,
    this.disease,
    this.medicine,
    this.token,
  });

  static fromJson(dynamic json) {
    return User(
      id: json['id'].toString(),
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? null,
      weight: json['weight'] ?? null,
      height: json['height'] ?? null,
      tel: json['tel'] ?? '',
      intolerance: json['intolerance'] ?? '',
      medicine: json['medicine'],
      disease: json['disease'],
      token: json['token'],
    );
  }

  @override
  String toString() {
    return 'User{email: $email, password: $password, id: $id, name: $name, gender: $gender, age: $age, weight: $weight, height: $height, tel: $tel, intolerance: $intolerance, disease: $disease, medicine: $medicine, token: $token}';
  }
}
