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

  User copyWith({
    String email,
    String password,
    String id,
    String name,
    String gender,
    int age,
    int weight,
    int height,
    String tel,
    String intolerance,
    String disease,
    String medicine,
    String token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      tel: tel ?? this.tel,
      intolerance: intolerance ?? this.id,
      medicine: medicine ?? this.id,
      disease: disease ?? this.id,
      token: token ?? this.token,
    );
  }

  static fromJson(dynamic json) {
    return User(
      id: json['id'].toString(),
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] != null && json['age'] != 0 ? json['age'] : null,
      weight: json['weight'] != null && json['weight'] != 0 ? json['weight'] : null,
      height: json['height'] != null && json['height'] != 0 ? json['height'] : null,
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

  @override
  bool operator ==(Object other) => identical(this, other) || other is User && runtimeType == other.runtimeType && email == other.email && password == other.password && id == other.id && name == other.name && gender == other.gender && age == other.age && weight == other.weight && height == other.height && tel == other.tel && intolerance == other.intolerance && disease == other.disease && medicine == other.medicine && token == other.token;

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ id.hashCode ^ name.hashCode ^ gender.hashCode ^ age.hashCode ^ weight.hashCode ^ height.hashCode ^ tel.hashCode ^ intolerance.hashCode ^ disease.hashCode ^ medicine.hashCode ^ token.hashCode;
}
