import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/constants.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/util/string_utils.dart';

class ContractRepository {
  Future<List<Contact>> fetchContact(String token) async {
    final response = await http.get(
      '${Http.api}/contact/user/',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );

    final jsonResponse = json.decode(response.body);
    final contacts = Contact.fromJsonArray(jsonResponse);

    return contacts;
  }

  Future<Null> addContact(Contact contact, String token) async {
    final response = await http.post(
      '${Http.api}/contact/user/',
      body: {
        'name': contact.name,
        'tel': contact.tel,
      },
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );
  }

  Future<Null> updateContact(String token, Contact contact) async {
    final dio = new Dio();

    final response = await dio.put(
      '${Http.api}/contact/user/${contact.id}',
      options: new Options(
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
        headers: {
          HttpHeaders.acceptHeader: acceptApplicationJson,
          HttpHeaders.authorizationHeader: createBearer(token),
        },
      ),
      data: {
        'name': contact.name,
        'tel': contact.tel,
      },
    );
  }

  Future<Null> deleteContact(String token, String contactId) async {
    final response = await http.delete(
      '${Http.api}/contact/user/$contactId',
      headers: {
        HttpHeaders.acceptHeader: acceptApplicationJson,
        HttpHeaders.authorizationHeader: createBearer(token),
      },
    );
    print(response.body);
  }
}
