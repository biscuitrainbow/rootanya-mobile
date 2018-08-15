import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferencesRepository();

  saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
  }


  deleteToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('token');
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}
