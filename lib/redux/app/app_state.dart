import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_state.dart';
import 'package:medical_app/redux/contract/contact_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_state.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/redux/notification_list/notification_list_state.dart';
import 'package:medical_app/redux/add_contact/add_contact_state.dart';
import 'package:medical_app/redux/usages/usage_state.dart';

class AppState {
  final NearbyPharmacyState nearbyPharmacyState;
  final MedicineListState medicineListState;
  final NotificationListState notificationListState;
  final MedicineNotificationListState medicineNotificationState;
  final AddMedicineState addMedicinState;
  final ContactsState contactState;
  final AddContactState addContactState;
  final UsageState usageState;
  final User user;

  AppState({
    this.nearbyPharmacyState,
    this.medicineListState,
    this.notificationListState,
    this.medicineNotificationState,
    this.addMedicinState,
    this.contactState,
    this.addContactState,
    this.usageState,
    this.user,
  });

  factory AppState.initial() {
    return new AppState(
      nearbyPharmacyState: NearbyPharmacyState.initial(),
      medicineListState: MedicineListState.initial(),
      notificationListState: NotificationListState.initial(),
      medicineNotificationState: MedicineNotificationListState.initial(),
      addMedicinState: AddMedicineState.initial(),
      contactState: ContactsState.initial(),
      addContactState: AddContactState.initial(),
      usageState: UsageState.initial(),
      user: null,
    );
  }

  AppState copyWith({
    NearbyPharmacyState nearbyPharmacyState,
    MedicineListState medicineListState,
    NotificationListState notificationListState,
    MedicineNotificationListState medicineNotificationState,
    AddMedicineState addMedicineState,
    ContactsState contactState,
    AddContactState addContactState,
    UsageState usageState,
    User user,
  }) {
    return new AppState(
      nearbyPharmacyState: nearbyPharmacyState ?? this.nearbyPharmacyState,
      medicineListState: medicineListState ?? this.medicineListState,
      notificationListState: notificationListState ?? this.notificationListState,
      medicineNotificationState: medicineNotificationState ?? this.medicineNotificationState,
      addMedicinState: addMedicineState ?? this.addMedicinState,
      contactState: contactState ?? this.contactState,
      addContactState: addContactState ?? this.addContactState,
      usageState: usageState ?? this.usageState,
      user: user ?? this.user,
    );
  }
}
