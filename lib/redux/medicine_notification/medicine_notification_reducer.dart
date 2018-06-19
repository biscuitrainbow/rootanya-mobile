import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_action.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_state.dart';
import 'package:redux/redux.dart';

final medicineNotificationReducer = combineReducers<MedicineNotificationListState>([
  new TypedReducer<MedicineNotificationListState,
      ReceivedMedicineNotificationAction>(
    receivedMedicineNotification,
  )
]);

MedicineNotificationListState receivedMedicineNotification(
  MedicineNotificationListState state,
  ReceivedMedicineNotificationAction action,
) {
  return state.copyWith(medicine: action.medicine);
//  return state.copyWith(
//    notificaions: action.notifications,
//  );
}
