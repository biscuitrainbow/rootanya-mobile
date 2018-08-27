import 'package:medical_app/data/model/medicine.dart';

class FetchNotifications {}

class FetchNotificationsSuccess {
  final List<Medicine> notifications;

  FetchNotificationsSuccess(this.notifications);
}

class ShowNotificationLoadingAction {}

class CancelAllNotification {}

class SetNotifications {}

class DeleteNotification {
  final int notificationId;

  DeleteNotification(this.notificationId);
}
