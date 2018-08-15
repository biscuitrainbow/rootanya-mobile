import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/util/string_utils.dart';

class MedicineRepository {
  Future<List<Medicine>> fetchAllMedicines(String userId) async {
    final response = await http.get('${Config.url}/medicine/$userId');
    print(response.body);
    final jsonResponse = json.decode(response.body);

    var medicines = Medicine.fromJsonArray(jsonResponse);
    return medicines;
  }

  Future<List<Medicine>> fetchMedicineByQuery(String query, String token) async {
    final response = await http.get(
      '${Config.url}/medicine/user?q=$query',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );

    final jsonResponse = json.decode(response.body);
    final medicines = Medicine.fromJsonArray(jsonResponse);

    return medicines;
  }

  Future<Null> addMedicine(Medicine medicine, String token) async {
    final response = await http.post(
      '${Config.url}/medicine/user',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
      body: {
        'barcode': medicine.barcode,
        'name': medicine.name,
        'ingredient': medicine.ingredient,
        'category': medicine.category,
        'type': medicine.type,
        'for': medicine.fors,
        'method': medicine.method,
        'notice': medicine.notice,
        'keeping': medicine.keeping,
        'forget': medicine.forget,
      },
    );

    print(response.body);
  }
}
