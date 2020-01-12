import 'package:rootanya/data/model/user.dart';
import 'package:rootanya/redux/add_contact/add_contact_state.dart';
import 'package:rootanya/redux/add_medicine/add_medicine_state.dart';
import 'package:rootanya/redux/contract/contact_state.dart';
import 'package:rootanya/redux/login/login_state.dart';
import 'package:rootanya/redux/medicine_list/medicine_list_state.dart';
import 'package:rootanya/redux/medicine_notification/medicine_notification_state.dart';
import 'package:rootanya/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:rootanya/redux/notification_list/notification_list_state.dart';
import 'package:rootanya/redux/profile/profile_screen_state.dart';
import 'package:rootanya/redux/register/register_screen_state.dart';
import 'package:rootanya/redux/usages/usage_state.dart';

class AppState {
  final NearbyPharmacyScreenState nearbyPharmacyState;
  final MedicineListScreenState medicineListState;
  final NotificationListScreenState notificationListState;
  final MedicineNotificationListState medicineNotificationState;
  final AddMedicineScreenState addMedicineState;
  final ContactScreenState contactState;
  final AddContactScreenState addContactState;
  final RegisterScreenState registerScreenState;
  final ProfileScreenState profileScreenState;
  final UsageState usageState;
  final LoginState loginState;
  final User user;
  final String token;

  AppState({
    this.nearbyPharmacyState,
    this.medicineListState,
    this.notificationListState,
    this.medicineNotificationState,
    this.addMedicineState,
    this.contactState,
    this.addContactState,
    this.registerScreenState,
    this.profileScreenState,
    this.usageState,
    this.loginState,
    this.user,
    this.token,
  });

  factory AppState.initial() {
    return AppState(
      nearbyPharmacyState: NearbyPharmacyScreenState.initial(),
      medicineListState: MedicineListScreenState.initial(),
      notificationListState: NotificationListScreenState.initial(),
      medicineNotificationState: MedicineNotificationListState.initial(),
      addMedicineState: AddMedicineScreenState.initial(),
      contactState: ContactScreenState.initial(),
      addContactState: AddContactScreenState.initial(),
      usageState: UsageState.initial(),
      loginState: LoginState.initial(),
      profileScreenState: ProfileScreenState.initial(),
      registerScreenState: RegisterScreenState.initial(),
      user: null,
      token: null,
    );
  }

  AppState copyWith({
    NearbyPharmacyScreenState nearbyPharmacyState,
    MedicineListScreenState medicineListState,
    NotificationListScreenState notificationListState,
    MedicineNotificationListState medicineNotificationState,
    AddMedicineScreenState addMedicineState,
    ContactScreenState contactState,
    AddContactScreenState addContactState,
    UsageState usageState,
    LoginState loginState,
    ProfileScreenState profileScreenState,
    RegisterScreenState registerScreenState,
    User user,
    String token,
  }) {
    return AppState(
      nearbyPharmacyState: nearbyPharmacyState ?? this.nearbyPharmacyState,
      medicineListState: medicineListState ?? this.medicineListState,
      notificationListState: notificationListState ?? this.notificationListState,
      medicineNotificationState: medicineNotificationState ?? this.medicineNotificationState,
      addMedicineState: addMedicineState ?? this.addMedicineState,
      contactState: contactState ?? this.contactState,
      addContactState: addContactState ?? this.addContactState,
      usageState: usageState ?? this.usageState,
      profileScreenState: profileScreenState ?? this.profileScreenState,
      loginState: loginState ?? this.loginState,
      registerScreenState: registerScreenState ?? this.registerScreenState,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              nearbyPharmacyState == other.nearbyPharmacyState &&
              medicineListState == other.medicineListState &&
              notificationListState == other.notificationListState &&
              medicineNotificationState == other.medicineNotificationState &&
              addMedicineState == other.addMedicineState &&
              contactState == other.contactState &&
              addContactState == other.addContactState &&
              registerScreenState == other.registerScreenState &&
              profileScreenState == other.profileScreenState &&
              usageState == other.usageState &&
              loginState == other.loginState &&
              user == other.user &&
              token == other.token;

  @override
  int get hashCode =>
      nearbyPharmacyState.hashCode ^
      medicineListState.hashCode ^
      notificationListState.hashCode ^
      medicineNotificationState.hashCode ^
      addMedicineState.hashCode ^
      contactState.hashCode ^
      addContactState.hashCode ^
      registerScreenState.hashCode ^
      profileScreenState.hashCode ^
      usageState.hashCode ^
      loginState.hashCode ^
      user.hashCode ^
      token.hashCode;



}
