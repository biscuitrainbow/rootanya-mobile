import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_reducer.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_reducer.dart';
import 'package:medical_app/redux/notification_list/notification_list_reducer.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_reducer.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_reducer.dart';
import 'package:medical_app/redux/contract/contact_reducer.dart';
import 'package:medical_app/redux/add_contact/add_contact_reducer.dart';
import 'package:medical_app/redux/usages/usage_reducer.dart';
import 'package:medical_app/redux/login/login_reducer.dart';
import 'package:medical_app/redux/auth/auth_reducer.dart';
import 'package:medical_app/redux/register/register_screen_reducer.dart';

AppState appReducer(AppState state, action) {
  var appState = new AppState(
    nearbyPharmacyState: nearbyPharmaciesReducer(state.nearbyPharmacyState, action),
    medicineListState: medicineListReducer(state.medicineListState, action),
    notificationListState: notificationListReducer(state.notificationListState, action),
    medicineNotificationState: medicineNotificationReducer(state.medicineNotificationState, action),
    addMedicinState: addMedicineReducer(state.addMedicinState, action),
    contactState: contractsReducers(state.contactState, action),
    addContactState: addContractsReducers(state.addContactState, action),
    usageState: usagesReducers(state.usageState, action),
    loginState: loginReducers(state.loginState, action),
    registerScreenState: registerReducers(state.registerScreenState, action),
    user: authReducers(state.user, action),
  );

  return appState;
}
