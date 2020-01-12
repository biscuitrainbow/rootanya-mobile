import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/medicine.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/notification_list/notification_list_action.dart';
import 'package:rootanya/ui/notification_list/notification_list_screen.dart';
import 'package:rootanya/util/widget_utils.dart';
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
  final bool isAuthenticated;

  NotificationListScreenViewModel({
    this.notifications,
    this.loadingStatus,
    this.onDelete,
    this.isAuthenticated,
  });

  static NotificationListScreenViewModel fromStore(Store<AppState> store) {
    return new NotificationListScreenViewModel(
      notifications: store.state.notificationListState.notifications,
      loadingStatus: store.state.notificationListState.loadingStatus,
      isAuthenticated: store.state.token != null,
      onDelete: (int notificationId) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          showToast("ลบแจ้งเตือนแล้ว");
        });

        store.dispatch(DeleteNotification(notificationId, completer));
      },
    );
  }
}
