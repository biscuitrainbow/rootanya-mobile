import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/notification.dart';

class MedicineNotificationListState {
  final Medicine medicine;

  MedicineNotificationListState({this.medicine});

  factory MedicineNotificationListState.initial() {
    return new MedicineNotificationListState(
      medicine: null,
    );
  }

  MedicineNotificationListState copyWith({Medicine medicine}) {
    return new MedicineNotificationListState(
      medicine: medicine ?? this.medicine,
    );
  }
}
