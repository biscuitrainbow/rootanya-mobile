import 'package:medical_app/data/model/medicine.dart';

class MedicineListQueryAction {
  final String query;

  MedicineListQueryAction(this.query);
}

class ReceivedMedicines {
  final List<Medicine> medicines;

  ReceivedMedicines(this.medicines);
}

class ErrorLoadingAction {

}

class ToggleSearching {}

class ToggleListening {}

class ShowListening {}

class HideListening {}

class ResetStateAction {}

class ShowLoading {}

class HideLoading {}
