import 'package:medical_app/data/model/medicine.dart';
import 'dart:async';

class AddMedicineAction {
  final Medicine medicine;
  final Completer completer;
  AddMedicineAction({
    this.completer,
    this.medicine,
  });
}

class RequestAddMedicineAction {}

class SuccessAddMedicineAction {}
