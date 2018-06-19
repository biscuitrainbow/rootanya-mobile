import 'package:medical_app/redux/medicine_list/medicine_list_state.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/redux/notification_list/notification_list_state.dart';

class AppState {
  final NearbyPharmacyState nearbyPharmacyState;
  final MedicineListState medicineListState;
  final NotificationListState notificationListState;
  final MedicineNotificationListState medicineNotificationState;
  AppState({
    this.nearbyPharmacyState,
    this.medicineListState,
    this.notificationListState,
    this.medicineNotificationState,
  });

  factory AppState.initial() {
    return new AppState(
      nearbyPharmacyState: NearbyPharmacyState.initial(),
      medicineListState: MedicineListState.initial(),
      notificationListState: NotificationListState.initial(),
      medicineNotificationState: MedicineNotificationListState.initial(),
    );
  }

  AppState copyWith({
    NearbyPharmacyState nearbyPharmacyState,
    MedicineListState medicineListState,
    NotificationListState notificationListState,
    MedicineNotificationListState medicineNotificationState
  }) {
    return new AppState(
      nearbyPharmacyState: nearbyPharmacyState ?? this.nearbyPharmacyState,
      medicineListState: medicineListState ?? this.medicineListState,
      notificationListState: notificationListState ?? this.notificationListState,
      medicineNotificationState: medicineNotificationState?? this.medicineNotificationState,
    );
  }
}
