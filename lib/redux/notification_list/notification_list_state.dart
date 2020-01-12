import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/medicine.dart';

class NotificationListScreenState {
  final List<Medicine> notifications;
  final LoadingStatus loadingStatus;

  NotificationListScreenState({
    this.notifications,
    this.loadingStatus,
  });

  factory NotificationListScreenState.initial() {
    return new NotificationListScreenState(
      notifications: [],
      loadingStatus: LoadingStatus.loading,
    );
  }

  NotificationListScreenState copyWith({
    List<Medicine> notifications,
    LoadingStatus loadingStatus,
  }) {
    return new NotificationListScreenState(
      notifications: notifications ?? this.notifications,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
