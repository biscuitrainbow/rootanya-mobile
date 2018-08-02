import 'package:medical_app/data/model/medicine.dart';

class FetchMedicineByQuery {
  final String query;

  FetchMedicineByQuery(this.query);
}

class FetchMedicineRequested {}

class FetchMedicineSuccess {
  final List<Medicine> medicines;

  FetchMedicineSuccess(this.medicines);
}

class FetchMedicinesError {}

class ToggleSearching {}

class ActivateSpeechRecognizer {}

class DeactivateSpeechRecognizer {}

class ResetStateAction {}
