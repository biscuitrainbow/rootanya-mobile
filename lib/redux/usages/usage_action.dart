import 'dart:async';

import 'package:rootanya/data/model/medicine.dart';
import 'package:rootanya/data/model/usage.dart';

class FetchUsagesAction {}

class DeleteUsageAction {
  final String usageId;
  final Completer<Null> completer;

  DeleteUsageAction(this.usageId, this.completer);
}

class RequestUsagesAction {}

class ReceiveUsagesAction {
  final List<Medicine> usages;

  ReceiveUsagesAction(this.usages);
}

class ErrorUsagesAction {}

class AddUsageAction {
  final Medicine medicine;
  final Completer completer;

  AddUsageAction(
    this.medicine,
    this.completer,
  );
}

class EditUsageAction {
  final Medicine medicine;
  final Completer completer;

  EditUsageAction(this.medicine, this.completer);
}
