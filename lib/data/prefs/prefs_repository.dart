import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferencesRepository();

  storeUser(String uid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('uid', uid);
  }


  deleteUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('uid');
  }

  Future<String> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('uid');
  }
}
