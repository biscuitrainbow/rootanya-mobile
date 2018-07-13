import 'package:medical_app/data/model/contact.dart';

class FetchContactsAction {
  final String uid;

  FetchContactsAction(this.uid);
}

class RequestContactsAction {}

class ReceiveContactsAction {
  final List<Contact> contracts;

  ReceiveContactsAction(this.contracts);
}

class ErrorContractsAction {}
