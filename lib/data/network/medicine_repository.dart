import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/medicine.dart';

class MedicineRepository {
  Future<List<Medicine>> fetchMedicineByQuery(String query) async {
    final response = await http.get('${Config.url}/medicine/query?q=$query');
    final jsonResponse = json.decode(response.body);

    var medicines = Medicine.fromJsonArray(jsonResponse);
    return medicines;
  }

  Future<Null> addMedicine(Medicine medicine) async {
    try {
      final response = await http.post('${Config.url}/medicine/user/1', body: {
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
        'user_id': medicine.userId,
      });
    } catch (error) {
      print(error.toString());
    }
  }
}
