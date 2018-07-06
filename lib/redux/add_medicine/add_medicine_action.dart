import 'package:medical_app/data/model/medicine.dart';

class AddMedicineAction {
  final Medicine medicine;

  AddMedicineAction({
    this.medicine,
  });
}

class RequestAddMedicineAction {}

class SuccessAddMedicineAction {}
