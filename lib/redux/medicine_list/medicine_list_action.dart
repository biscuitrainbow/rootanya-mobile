import 'package:medical_app/data/model/medicine.dart';

class FetchMedicineByQueryAction {
  final String query;

  FetchMedicineByQueryAction(this.query);
}

class ReceivedQueryMedicines {
  final List<Medicine> medicines;

  ReceivedQueryMedicines(this.medicines);
}

class FetchAllMedicineAction {}

class ReceivedMedicines {
  final List<Medicine> medicines;

  ReceivedMedicines(this.medicines);
}

class ErrorLoadingAction {}

class ToggleSearching {}

class ToggleListening {}

class ShowListening {}

class HideListening {}

class ShowLoading {}

class HideLoading {}

class ResetStateAction {}
