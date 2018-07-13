import 'dart:async';

import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/usage.dart';

class FetchUsagesAction {}

class RequestUsagesAction {}

class ReceiveUsagesAction {
  final List<Medicine> usages;

  ReceiveUsagesAction(this.usages);
}

class ErrorUsagesAction {}

class AddUsageAction {
  final Medicine medicine;
  final int volume;
  final Completer completer;

  AddUsageAction(
    this.medicine,
    this.volume,
    this.completer,
  );
}
