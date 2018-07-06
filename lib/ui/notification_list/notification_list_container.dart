import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/notification_list/notification_list_screen.dart';
import 'package:redux/redux.dart';

class NotificationListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(new FetchNotificationListAction()),
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new NotificationListScreen(
          notifications: vm.notifications,
          loadingStatus: vm.loadingStatus,
        );
      },
    );
  }
}

class ViewModel {
  final List<Medicine> notifications;
  final LoadingStatus loadingStatus;

  ViewModel({
    this.notifications,
    this.loadingStatus,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      notifications: store.state.notificationListState.notifications,
      loadingStatus: store.state.notificationListState.loadingStatus,
    );
  }
}
