import 'package:rootanya/data/model/medicine.dart';

class FetchMedicineByQuery {
  final String query;

  FetchMedicineByQuery(this.query);
}

class FetchAllMedicine {}

class FetchMedicineRequested {}

class FetchMedicineSuccess {
  final List<Medicine> medicines;

  FetchMedicineSuccess(this.medicines);
}

class FetchQueriedMedicineSuccess {
  final List<Medicine> medicines;

  FetchQueriedMedicineSuccess(this.medicines);
}

class FetchMedicinesError {}

class ToggleSearching {}

class ActivateSpeechRecognizer {}

class DeactivateSpeechRecognizer {}

class ResetStateAction {}
