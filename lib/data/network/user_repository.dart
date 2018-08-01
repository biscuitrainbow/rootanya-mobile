import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/usage.dart';
import 'package:medical_app/data/model/user.dart';

class UserRepository {
  Future<User> login(String email, String password) async {
    final response = await http.post('${Config.url}/user/login', body: {
      'email': email,
      'password': password,
    });

    final jsonResponse = json.decode(response.body);

    var user = User.fromJson(jsonResponse['data']);
    return user;
  }

  Future<Null> logout() async {
    final response = await http.post('${Config.url}/user/logout');
    final jsonResponse = json.decode(response.body);

    print('logout');
  }

  Future<User> loginById(String id) async {
    final response = await http.post('${Config.url}/user/login/$id', body: {
      'id': id,
    });

    final jsonResponse = json.decode(response.body);

    var user = User.fromJson(jsonResponse['data']);
    return user;
  }

  Future<User> update(User user) async {
    final response = await http.post('${Config.url}/user/update/${user.id}', body: {
      'name': user.name,
      'gender': user.gender,
      'age': user.age.toString(),
      'height': user.height.toString(),
      'weight': user.weight.toString(),
      'tel': user.tel,
      'intolerance': user.intolerance,
    });

    final jsonResponse = json.decode(response.body);
    var updatedUser = User.fromJson(jsonResponse);

    return updatedUser;
  }

  Future<User> register(User user) async {
    final response = await http.post('${Config.url}/user/register/', body: {
      'email': user.email,
      'password': user.password,
      'name': user.name,
      'gender': user.gender,
      'age': user.age.toString() ?? null,
      'height': user.height.toString() ?? null,
      'weight': user.weight.toString() ?? null,
      'tel': user.tel ?? null,
      'intolerance': user.intolerance ?? null,
    });

    print(response.body);

    final jsonResponse = json.decode(response.body);
    var registeredUser = User.fromJson(jsonResponse);

    return registeredUser;
  }
}
