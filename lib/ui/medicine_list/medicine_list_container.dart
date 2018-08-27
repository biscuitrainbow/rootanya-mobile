import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/medicine_notification/medicine_notification_action.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_mode.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_screen.dart';
import 'package:redux/redux.dart';

class MedicineListContainer extends StatefulWidget {
  final MedicineListMode mode;

  MedicineListContainer({this.mode});

  @override
  _MedicineListContainerState createState() => _MedicineListContainerState();
}

class _MedicineListContainerState extends State<MedicineListContainer> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      onDispose: (Store store) => store.dispatch(ResetStateAction()),
      converter: MedicineListScreenViewModel.fromStore,
      builder: (BuildContext context, MedicineListScreenViewModel vm) {
        return MedicineListScreen(
          mode: widget.mode,
          viewModel: vm,
        );
      },
    );
  }
}

class MedicineListScreenViewModel {
  final List<Medicine> queriedMedicines;
  final List<Medicine> medicines;

  final bool isSearching;
  final bool isListening;
  final Function onSearchClick;
  final Function(String) onQueryChanged;
  final Function onVoiceClicked;
  final LoadingStatus loadingStatus;
  final VoidCallback showListening;
  final VoidCallback hideListening;
  final Function(Time, Medicine) onAddNotification;

  MedicineListScreenViewModel({
    this.medicines,
    this.queriedMedicines,
    this.isSearching,
    this.isListening,
    this.onSearchClick,
    this.onVoiceClicked,
    this.onQueryChanged,
    this.loadingStatus,
    this.showListening,
    this.hideListening,
    this.onAddNotification,
  });

  static MedicineListScreenViewModel fromStore(Store<AppState> store) {
    return new MedicineListScreenViewModel(
      medicines: store.state.medicineListState.medicines,
      isSearching: store.state.medicineListState.isSearching,
      isListening: store.state.medicineListState.isListening,
      loadingStatus: store.state.medicineListState.loadingStatus,
      showListening: () => store.dispatch(new ActivateSpeechRecognizer()),
      hideListening: () => store.dispatch(new DeactivateSpeechRecognizer()),
      onSearchClick: () => store.dispatch(new ToggleSearching()),
      onQueryChanged: (String query) => store.dispatch(FetchMedicineByQuery(query)),
      onAddNotification: (Time time, Medicine medicine) => store.dispatch(AddMedicineNotification(time, medicine)),
    );
  }
}
