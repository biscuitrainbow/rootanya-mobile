import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:rootanya/constants.dart';
import 'package:rootanya/data/model/user.dart';
import 'package:rootanya/exception/http_exception.dart';
import 'package:rootanya/util/string_utils.dart';

class UserRepository {
  Future<User> login(String email, String password) async {
    final response = await http.post(
      '${Http.api}/user/login',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      throw UnauthorizedException('อีเมลล์หรือรหัสผ่านไม่ถูกต้อง');
    }

    final jsonResponse = json.decode(response.body);
    final user = User.fromJson(jsonResponse);

    return user;
  }

  Future<Null> logout() async {
    final response = await http.post('${Http.api}/user/logout');
  }

  Future<User> fetchUser(String token) async {
    final response = await http.get(
      '${Http.api}/user',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );

    final jsonResponse = json.decode(response.body);
    final user = User.fromJson(jsonResponse);

    return user;
  }

  Future<Null> update(User user, String token) async {
    final dio = Dio();
    final response = await dio.put(
      '${Http.api}/user',
      options: new Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          HttpHeaders.acceptHeader: acceptApplicationJson,
          HttpHeaders.authorizationHeader: createBearer(token),
        },
      ),
      data: {
        'name': user.name,
        'gender': user.gender,
        'age': user.age.toString() ?? null,
        'height': user.height.toString() ?? null,
        'weight': user.weight.toString() ?? null,
        'tel': user.tel ?? null,
        'intolerance': user.intolerance ?? null,
        'medicine': user.medicine ?? null,
        'disease': user.disease ?? null,
      },
    );

    print(response.data);
  }

  Future<User> register(User user) async {
    final response = await http.post('${Http.api}/user/register', headers: {
      HttpHeaders.acceptHeader: acceptApplicationJson,
    }, body: {
      'email': user.email,
      'password': user.password,
      'name': user.name,
      'gender': user.gender,
      'age': user.age.toString() ?? null,
      'height': user.height.toString() ?? null,
      'weight': user.weight.toString() ?? null,
      'tel': user.tel ?? null,
      'intolerance': user.intolerance ?? null,
      'medicine': user.medicine ?? null,
      'disease': user.disease ?? null,
    });
    print(response.body);

    if (response.statusCode == 422) {
      throw UnProcessableEntity('คุณกรอกข้อมูลไม่ถูกต้อง');
    }

    final jsonResponse = json.decode(response.body);
    var registeredUser = User.fromJson(jsonResponse);

    return registeredUser;
  }
}
