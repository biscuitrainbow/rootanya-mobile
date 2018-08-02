import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/medicine.dart';

class HistoryRepository {

  Future<Null> addUsage(String userId,
      String medicineId,
      int volume,) async {
    final response = await http.post(
        '${Config.url}/user/$userId/history', body: {
      'medicine_id': medicineId,
      'volume': volume.toString(),
    });
    print(response.body);
    final jsonResponse = json.decode(response.body);
  }

  Future<Null> deleteUsage(String usageId) async {
    final response = await http.delete('${Config.url}/history/$usageId');
    print(response.body);
  }

  Future<Null> updateUsage(Medicine usage) async {
    final response = await http.post(
        '${Config.url}/history/${usage.usageId}', body: {
      'volume': usage.volume.toString(),
    });

    print(response.body);
  }

  Future<List<Medicine>> fetchUsages(String userId) async {
    final response = await http.get('${Config.url}/user/$userId/history');
    print(response.request);
    final jsonResponse = json.decode(response.body);

    var usages = Medicine.fromJsonUsageArray(jsonResponse);

    return usages;
  }
}

