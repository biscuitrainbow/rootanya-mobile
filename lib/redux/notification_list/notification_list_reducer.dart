import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_state.dart';
import 'package:redux/redux.dart';

final notificationListReducer = combineReducers<NotificationListState>([
  new TypedReducer<NotificationListState, FetchNotificationsSuccess>(
    _fetchNotificationsSuccess,
  )
]);

NotificationListState _fetchNotificationsSuccess(
  NotificationListState state,
  FetchNotificationsSuccess action,
) {
  return state.copyWith(
    notifications: action.notifications,
    loadingStatus: LoadingStatus.success,
  );
}
