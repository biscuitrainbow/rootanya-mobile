import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/medicine_notification/medicine_notification_action.dart';
import 'package:rootanya/redux/medicine_notification/medicine_notification_state.dart';
import 'package:redux/redux.dart';

final medicineNotificationReducer = combineReducers<MedicineNotificationListState>([
  new TypedReducer<MedicineNotificationListState, FetchMedicineNotificationSuccess>(
    _fetchMedicineNotificationSuccess,
  )
]);

MedicineNotificationListState _fetchMedicineNotificationSuccess(
  MedicineNotificationListState state,
  FetchMedicineNotificationSuccess action,
) {
  return state.copyWith(
    medicine: action.medicine,
    loadingStatus: LoadingStatus.success,
  );
}
