import 'package:medical_app/data/model/medicine.dart';

class NotificationListState {
  final List<Medicine> notifications;

  NotificationListState({this.notifications});

  factory NotificationListState.initial() {
    return new NotificationListState(
      notifications: [],
    );
  }

  NotificationListState copyWith({List<Medicine> notificaions}) {
    return new NotificationListState(
      notifications: notificaions ?? this.notifications,
    );
  }
}
