import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/usage.dart';

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
    final response = await http.get('${Config.url}/user/$userId/notification/$medicineId');
    final jsonResponse = json.decode(response.body);

    var medicine = Medicine.fromJsonNotification(jsonResponse);

    return medicine;
  }

  Future<List<Contact>> fetchContact(String userId) async {
    final response = await http.get('${Config.url}/contact/user/$userId');
    final jsonResponse = json.decode(response.body);

    var contacts = Contact.fromJsonArray(jsonResponse);
    return contacts;
  }

  Future<Null> addContact(Contact contact, String userId) async {
    final response = await http.post('${Config.url}/contact/user/$userId', body: {
      'name': contact.name,
      'tel': contact.tel,
    });

    final jsonResponse = json.decode(response.body);
  }

  Future<Null> updateContact(Contact contact) async {
    final response = await http.post('${Config.url}/contact/${contact.id}', body: {
      'name': contact.name,
      'tel': contact.tel,
    });

    print(response.body);

    final jsonResponse = json.decode(response.body);
  }

  Future<Null> deleteContact(String contact) async {
    final response = await http.delete('${Config.url}/contact/$contact');

    print(response.body);

    final jsonResponse = json.decode(response.body);
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

  Future<Null> addUsage(
    String userId,
    String medicineId,
    int volume,
  ) async {
    final response = await http.post('${Config.url}/user/$userId/usage', body: {
      'medicine_id': medicineId,
      'volume': volume.toString(),
    });

    final jsonResponse = json.decode(response.body);
  }

  Future<Null> deleteUsage(String usageId) async {
    final response = await http.delete('${Config.url}/usage/$usageId/');
  }

  Future<Null> updateUsage(Medicine usage) async {
    final response = await http.post('${Config.url}/usage/${usage.usageId}/', body: {
      'volume': usage.volume.toString(),
    });
  }

  Future<List<Medicine>> fetchUsages(String userId) async {
    final response = await http.get('${Config.url}/user/$userId/usages');
    final jsonResponse = json.decode(response.body);

    var usages = Medicine.fromJsonUsageArray(jsonResponse);

    return usages;
  }
}
