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
}
