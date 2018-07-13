import 'dart:async';

import 'package:medical_app/data/model/contact.dart';

// Add
class AddContactAction {
  final Contact contact;
  final Completer completer;

  AddContactAction(
    this.contact,
    this.completer,
  );
}

class RequestAddContactAction {}

class SuccessAddContactAction {}

class ErrorAddContactAction {}

// Edit
class EditContactAction {
  final Contact contact;
  final Completer completer;

  EditContactAction(
    this.contact,
    this.completer,
  );
}

class RequestEditContactAction {}

class SuccessEditContactAction {}

class ErrorEditContactAction {}

// Delete
class DeleteContactAction {
  final Contact contact;
  final Completer completer;

  DeleteContactAction(this.contact, this.completer);
}
