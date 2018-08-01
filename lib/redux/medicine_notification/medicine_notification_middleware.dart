import 'package:medical_app/data/network/notification_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_action.dart';
import 'package:medical_app/service/notification_service.dart';
import 'package:redux/redux.dart';
import 'package:uuid/uuid.dart';

List<Middleware<AppState>> createMedicineNotificationMiddleware(
  NotificationRepository notificationRepository,
  NotificationService notificationService,
) {
  return [
    new TypedMiddleware<AppState, FetchMedicineNotificationAction>(
      fetchMedicineNotification(notificationRepository),
    ),
    new TypedMiddleware<AppState, AddMedicineNotificationAction>(
      addMedicineNotification(
        notificationService,
        notificationRepository,
      ),
    ),
  ];
}

Middleware<AppState> fetchMedicineNotification(
  NotificationRepository notificationRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchMedicineNotificationAction) {
      try {
        var user = store.state.user;
        var medicine = await notificationRepository.fetchMedicineNotification(
          user.id,
          action.medicineId,
        );

        store.dispatch(new ReceivedMedicineNotificationAction(medicine));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> addMedicineNotification(
  NotificationService notificationService,
  NotificationRepository notificationRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddMedicineNotificationAction) {
      try {
        int id = await notificationService.addNotification(
          action.time,
          action.medicine,
        );

        var user = store.state.user;
        await notificationRepository.addNotification(
          user.id,
          action.medicine.id,
          '${action.time.hour}:${action.time.minute}',
          id,
        );

        store.dispatch(new FetchMedicineNotificationAction(action.medicine.id));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
