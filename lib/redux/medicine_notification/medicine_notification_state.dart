import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/medicine.dart';

class MedicineNotificationListState {
  final Medicine medicine;
  final LoadingStatus loadingStatus;

  MedicineNotificationListState({
    this.medicine,
    this.loadingStatus,
  });

  factory MedicineNotificationListState.initial() {
    return new MedicineNotificationListState(
      medicine: null,
      loadingStatus: LoadingStatus.loading,
    );
  }

  MedicineNotificationListState copyWith({
    Medicine medicine,
    LoadingStatus loadingStatus,
  }) {
    return new MedicineNotificationListState(
      medicine: medicine ?? this.medicine,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
