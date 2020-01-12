import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rootanya/data/model/medicine.dart';

class FetchMedicineNotification {
  final String medicineId;

  FetchMedicineNotification(this.medicineId);
}

class FetchMedicineNotificationSuccess {
  final Medicine medicine;

  FetchMedicineNotificationSuccess(this.medicine);
}

class AddMedicineNotification {
  final Time time;
  final Medicine medicine;
  final Completer<Null> completer;

  AddMedicineNotification(this.time, this.medicine, this.completer);
}
