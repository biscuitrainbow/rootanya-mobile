import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/medicine.dart';

class UserRepository {
  Future<List<Medicine>> fetchNotifications(String userId) async {
    final response = await http.get('${Config.url}/user/$userId/notification');
    final jsonResponse = json.decode(response.body);

    var notifications = Medicine.fromJsonNotificationArray(jsonResponse);

    return notifications;
  }

  Future<Medicine> fetchMedicineNotification(
    String userId,
    String medicineId,
  ) async {
    final response =
        await http.get('${Config.url}/user/$userId/notification/$medicineId');
    final jsonResponse = json.decode(response.body);

    var medicine = Medicine.fromJsonNotification(jsonResponse);

    return medicine;
  }

  Future<Null> addNotification(
    String userId,
    String medicineId,
    String at,
    int id,
  ) async {
    final response = await http.post('${Config.url}/user/$userId/notification/$medicineId', body: {
      'uuid': id.toString(),
      'at': at,
    });

    final jsonResponse = json.decode(response.body);

  }
}
