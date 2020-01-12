import 'package:rootanya/data/model/medicine.dart';
import 'dart:async';

class AddMedicineAction {
  final Medicine medicine;
  final Completer completer;
  AddMedicineAction({
    this.completer,
    this.medicine,
  });
}

class ShowAddMedicineLoadingAction {}

class HideAddMedicineLoadingAction {}
