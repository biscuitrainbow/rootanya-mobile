import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_action.dart';
import 'package:medical_app/ui/add_notification/medicine_notification_list_screen.dart';
import 'package:redux/redux.dart';

class MedicineNotificationListContainer extends StatelessWidget {
  final String medicineId;
  final bool isAddingNotification;

  const MedicineNotificationListContainer({
    Key key,
    this.medicineId,
    this.isAddingNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      onInit: (Store store) => store.dispatch(new FetchMedicineNotificationAction(medicineId)),
      distinct: true,
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new MedicineNotificationListScreen(
          isAddingNotification: isAddingNotification,
          loadingStatus: vm.loadingStatus,
          medicine: vm.medicine,
          onAddNotification: vm.onAddNotification,
        );
      },
    );
  }
}

class ViewModel {
  final Medicine medicine;
  final Function(Time, Medicine) onAddNotification;
  final LoadingStatus loadingStatus;

  ViewModel({
    this.medicine,
    this.onAddNotification,
    this.loadingStatus,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      medicine: store.state.medicineNotificationState.medicine,
      onAddNotification: (Time time, Medicine medicine) => store.dispatch(new AddMedicineNotificationAction(time, medicine)),
      loadingStatus: store.state.medicineNotificationState.loadingStatus,
    );
  }
}
