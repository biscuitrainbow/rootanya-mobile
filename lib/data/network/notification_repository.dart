import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medical_app/constants.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/util/string_utils.dart';

class NotificationRepository {
  Future<List<Medicine>> fetchMedicineWithNotifications(String token) async {
    final response = await http.get(
      '${Http.api}/notification/user/',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );
    final jsonResponse = json.decode(response.body);

    var medicinesWithNotifications = Medicine.fromJsonNotificationArray(jsonResponse);
    return medicinesWithNotifications;
  }

  Future<Null> addNotification(
    String token,
    String medicineId,
    String at,
    int id,
  ) async {
    final response = await http.post(
      '${Http.api}/notification/user',
      body: {
        'uuid': id.toString(),
        'at': at,
        'medicine_id': medicineId,
      },
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );

    print(response.body);
  }

  Future<Null> deleteNotification(int notificationId, String token) async {
    final response = await http.delete(
      '${Http.api}/notification/user/$notificationId',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );
  }

  Future<Medicine> fetchNotificationByMedicine(
    String userId,
    String medicineId,
  ) async {
    final response = await http.get('${Http.api}/user/$userId/notification/$medicineId');
    final jsonResponse = json.decode(response.body);

    var medicine = Medicine.fromJsonNotification(jsonResponse);

    return medicine;
  }
}
