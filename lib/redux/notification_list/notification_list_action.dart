import 'package:medical_app/data/model/medicine.dart';

class FetchNotifications {}

class FetchNotificationsSuccess {
  final List<Medicine> notifications;

  FetchNotificationsSuccess(this.notifications);
}


class DeleteNotification{
  final String notificationId;

  DeleteNotification(this.notificationId);
}

