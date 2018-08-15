import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/util/string_utils.dart';

class UsageRepository {
  Future<List<Medicine>> fetchUsages(String token) async {
    final response = await http.get(
      '${Config.url}/usage/user',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );

    final jsonResponse = json.decode(response.body);
    final usages = Medicine.fromJsonUsageArray(jsonResponse);

    return usages;
  }

  Future<Null> addUsage(String token, String medicineId, int volume) async {
    final response = await http.post(
      '${Config.url}/usage/user',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
      body: {
        'medicine_id': medicineId,
        'volume': volume.toString(),
      },
    );
  }

  Future<Null> updateUsage(String token, Medicine usage) async {
    final dio = new Dio();

    final response = await dio.put(
      '${Config.url}/usage/user/${usage.usageId}',
      options: new Options(
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
        headers: {
          HttpHeaders.acceptHeader: acceptApplicationJson,
          HttpHeaders.authorizationHeader: createBearer(token),
        },
      ),
      data: {
        'volume': usage.volume.toString(),
      },
    );
    }

  Future<Null> deleteUsage(String token, String usageId) async {
    print(usageId);

    final response = await http.delete(
      '${Config.url}/usage/user/$usageId',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );
  }
}
