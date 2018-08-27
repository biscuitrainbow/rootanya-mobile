import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/ui/notification_list/notification_list_screen.dart';
import 'package:redux/redux.dart';

class NotificationListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(new FetchNotifications()),
      converter: NotificationListScreenViewModel.fromStore,
      builder: (BuildContext context, NotificationListScreenViewModel vm) {
        return NotificationListScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class NotificationListScreenViewModel {
  final List<Medicine> notifications;
  final LoadingStatus loadingStatus;
  final Function(int) onDelete;

  NotificationListScreenViewModel({
    this.notifications,
    this.loadingStatus,
    this.onDelete,
  });

  static NotificationListScreenViewModel fromStore(Store<AppState> store) {
    return new NotificationListScreenViewModel(
      notifications: store.state.notificationListState.notifications,
      loadingStatus: store.state.notificationListState.loadingStatus,
      onDelete: (int notificationId) {
        store.dispatch(DeleteNotification(notificationId));
      },
    );
  }
}
