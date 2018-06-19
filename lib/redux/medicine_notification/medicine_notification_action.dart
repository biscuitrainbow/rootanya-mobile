import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/notification.dart';

class FetchMedicineNotificationAction {
  final String medicineId;

  FetchMedicineNotificationAction(this.medicineId);
}

class ReceivedMedicineNotificationAction {
  final Medicine medicine;

  ReceivedMedicineNotificationAction(this.medicine);
}

class AddMedicineNotificationAction {
  final Time time;
  final Medicine medicine;

  AddMedicineNotificationAction(this.time, this.medicine);
}
