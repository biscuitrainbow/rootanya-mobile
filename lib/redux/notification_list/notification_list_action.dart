import 'package:medical_app/data/model/medicine.dart';

class FetchNotificationListAction {}

class ReceivedNotificationListAction {
  final List<Medicine> notifications;

  ReceivedNotificationListAction(this.notifications);
}
