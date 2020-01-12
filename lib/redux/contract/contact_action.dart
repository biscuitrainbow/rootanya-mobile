import 'package:rootanya/data/model/contact.dart';

class FetchContacts {
}

class FetchContactsRequested {}

class FetchContactSuccess {
  final List<Contact> contracts;

  FetchContactSuccess(this.contracts);
}

class FetchContactError {}
