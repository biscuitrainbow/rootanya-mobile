import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_app/config.dart';
import 'package:medical_app/data/model/contact.dart';

class ContractRepository {
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

}
