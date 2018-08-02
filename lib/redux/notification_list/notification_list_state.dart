import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';

class NotificationListState {
  final List<Medicine> notifications;
  final LoadingStatus loadingStatus;

  NotificationListState({
    this.notifications,
    this.loadingStatus,
  });

  factory NotificationListState.initial() {
    return new NotificationListState(
      notifications: [],
      loadingStatus: LoadingStatus.loading,
    );
  }

  NotificationListState copyWith({
    List<Medicine> notifications,
    LoadingStatus loadingStatus,
  }) {
    return new NotificationListState(
      notifications: notifications ?? this.notifications,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
