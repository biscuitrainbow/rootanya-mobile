import 'package:medical_app/data/network/google_map_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createNotificationListMiddleware(
  UserRepository userRepository,
) {
  return [
    new TypedMiddleware<AppState, FetchNotificationListAction>(
      _fetchNotifications(userRepository),
    ),
    new TypedMiddleware<AppState, DeleteNotification>(
      _deleteNotification(userRepository),
    ),
  ];
}

Middleware<AppState> _fetchNotifications(
  UserRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchNotificationListAction) {
      try {
        var user = store.state.user;
        var notifications = await userRepository.fetchNotifications(user.id);
        store.dispatch(new ReceivedNotificationListAction(notifications));
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> _deleteNotification(
  UserRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is DeleteNotification) {
      try {
        await userRepository.deleteNotification(action.notificationId);
        store.dispatch(FetchNotificationListAction());
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}
