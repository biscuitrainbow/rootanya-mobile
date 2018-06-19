import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_reducer.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_reducer.dart';
import 'package:medical_app/redux/notification_list/notification_list_reducer.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_reducer.dart';

AppState appReducer(AppState state, action) {
  var appState = new AppState(
    nearbyPharmacyState: nearbyPharmaciesReducer(state.nearbyPharmacyState, action),
    medicineListState: medicineListReducer(state.medicineListState, action),
    notificationListState: notificationListReducer(state.notificationListState,action),
    medicineNotificationState: medicineNotificationReducer(state.medicineNotificationState,action),
  );

  return appState;
}
