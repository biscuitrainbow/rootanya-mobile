import 'package:medical_app/data/model/medicine.dart';

class FetchNotificationListAction {}

class DeleteNotification{
  final String notificationId;

  DeleteNotification(this.notificationId);
}

class ReceivedNotificationListAction {
  final List<Medicine> notifications;

  ReceivedNotificationListAction(this.notifications);
}
