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
      fetchNearbyPharmacy(userRepository),
    ),
  ];
}

Middleware<AppState> fetchNearbyPharmacy(
  UserRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchNotificationListAction) {
      try {
        var notifications = await userRepository.fetchNotifications('1');
        store.dispatch(new ReceivedNotificationListAction(notifications));
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}
