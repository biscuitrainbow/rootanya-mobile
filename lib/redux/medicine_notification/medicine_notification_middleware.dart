import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_action.dart';
import 'package:medical_app/service/notification_service.dart';
import 'package:redux/redux.dart';
import 'package:uuid/uuid.dart';

List<Middleware<AppState>> createMedicineNotificationMiddleware(
  UserRepository userRepository,
  NotificationService notificationService,
) {
  return [
    new TypedMiddleware<AppState, FetchMedicineNotificationAction>(
      fetchMedicineNotification(userRepository),
    ),
    new TypedMiddleware<AppState, AddMedicineNotificationAction>(
      addMedicineNotification(
        notificationService,
        userRepository,
      ),
    ),
  ];
}

Middleware<AppState> fetchMedicineNotification(
  UserRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchMedicineNotificationAction) {
      try {
        var medicine = await userRepository.fetchMedicineNotification(
          '1',
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
  UserRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is AddMedicineNotificationAction) {
      try {
        int id = await notificationService.addNotification(
          action.time,
          action.medicine,
        );

        await userRepository.addNotification(
          '1',
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
