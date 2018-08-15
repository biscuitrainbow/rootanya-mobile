import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_state.dart';
import 'package:redux/redux.dart';

final notificationListReducer = combineReducers<NotificationListScreenState>([
  new TypedReducer<NotificationListScreenState, FetchNotificationsSuccess>(
    _fetchNotificationsSuccess,
  ),
  new TypedReducer<NotificationListScreenState, ShowNotificationLoadingAction>(
    _showLoading,
  )
]);

NotificationListScreenState _fetchNotificationsSuccess(
  NotificationListScreenState state,
  FetchNotificationsSuccess action,
) {
  return state.copyWith(
    notifications: action.notifications,
    loadingStatus: LoadingStatus.success,
  );
}

NotificationListScreenState _showLoading(
  NotificationListScreenState state,
  ShowNotificationLoadingAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}
