import 'package:medical_app/data/network/notification_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/service/notification_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMedicineNotificationMiddleware(
  NotificationRepository notificationRepository,
  NotificationService notificationService,
) {
  return [
    new TypedMiddleware<AppState, FetchMedicineNotification>(
      _fetchMedicineNotification(notificationRepository),
    ),
    new TypedMiddleware<AppState, AddMedicineNotification>(
      _addMedicineNotification(notificationService, notificationRepository),
    ),
  ];
}

Middleware<AppState> _fetchMedicineNotification(
  NotificationRepository notificationRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchMedicineNotification) {
      try {
        var user = store.state.user;
        var medicine = await notificationRepository.fetchNotificationByMedicine(
          user.id,
          action.medicineId,
        );

        store.dispatch(new FetchMedicineNotificationSuccess(medicine));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> _addMedicineNotification(
  NotificationService notificationService,
  NotificationRepository notificationRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddMedicineNotification) {
      try {
        final token = store.state.token;
        int id = await notificationService.createNotification(
          action.time,
          action.medicine,
        );

        await notificationRepository.addNotification(
          token,
          action.medicine.id,
          '${action.time.hour}:${action.time.minute}',
          id,
        );

        action.completer.complete(null);

        store.dispatch(FetchMedicineNotification(action.medicine.id));
        store.dispatch(FetchNotifications());
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
