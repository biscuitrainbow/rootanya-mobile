import 'package:medical_app/data/network/notification_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/service/notification_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createNotificationListMiddleware(
  NotificationRepository notificationRepository,
  NotificationService notificationService,
) {
  return [
    TypedMiddleware<AppState, FetchNotifications>(
      _fetchNotifications(notificationRepository),
    ),
    TypedMiddleware<AppState, SetNotifications>(
      _setNotifications(notificationRepository, notificationService),
    ),
    TypedMiddleware<AppState, DeleteNotification>(
      _deleteNotification(notificationRepository, notificationService),
    ),
    TypedMiddleware<AppState, CancelAllNotification>(
      _cancelAllNotification(notificationRepository, notificationService),
    ),
  ];
}

Middleware<AppState> _fetchNotifications(
  NotificationRepository notificationRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchNotifications) {
      next(ShowNotificationLoadingAction());
      final token = store.state.token;

      try {
        final medicinesWithNotifications = await notificationRepository.fetchMedicineWithNotifications(token);
        store.dispatch(new FetchNotificationsSuccess(medicinesWithNotifications));
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> _setNotifications(
  NotificationRepository notificationRepository,
  NotificationService notificationService,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is SetNotifications) {
      final token = store.state.token;

      try {
        final medicinesWithNotifications = await notificationRepository.fetchMedicineWithNotifications(token);
        await notificationService.setNotification(medicinesWithNotifications);
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> _deleteNotification(
  NotificationRepository notificationRepository,
  NotificationService notificationService,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is DeleteNotification) {
      final token = store.state.token;

      try {
        await notificationRepository.deleteNotification(action.notificationId, token);
        await notificationService.cancelNotification(action.notificationId);

        store.dispatch(FetchNotifications());
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> _cancelAllNotification(
  NotificationRepository notificationRepository,
  NotificationService notificationService,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is CancelAllNotification) {
      try {
        notificationService.cancelAllNotification();
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}
