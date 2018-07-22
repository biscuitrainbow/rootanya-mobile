import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_screen.dart';
import 'package:redux/redux.dart';

class MedicineListContainer extends StatefulWidget {
  @override
  _MedicineListContainerState createState() => _MedicineListContainerState();
}

class _MedicineListContainerState extends State<MedicineListContainer> {
  final queryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {

        return new MedicineListScreen(
          medicines: vm.queriedMedicines,
          isSearching: vm.isSearching,
          isListening: vm.isListening,
          isLoading: vm.isLoading,
          loadingStatus: vm.loadingStatus,
          onSearchClick: vm.onSearchClick,
          onVoiceClicked: vm.onVoiceClicked,
          onDispose: vm.onDispose,
          queryController: queryController,
          onSearchQueryChanged: vm.onQueryChanged,
          showListening: vm.showListening,
          hideListening: vm.hideListening,
        );
      },
    );
  }
}

class ViewModel {
  final List<Medicine> queriedMedicines;
  final List<Medicine> medicines;

  final bool isSearching;
  final bool isListening;
  final bool isLoading;
  final Function onSearchClick;
  final Function(String) onQueryChanged;
  final Function onVoiceClicked;
  final Function onDispose;
  final LoadingStatus loadingStatus;

  final VoidCallback showListening;
  final VoidCallback hideListening;

  ViewModel({
    this.medicines,
    this.queriedMedicines,
    this.isSearching,
    this.isListening,
    this.isLoading,
    this.onSearchClick,
    this.onVoiceClicked,
    this.onQueryChanged,
    this.onDispose,
    this.loadingStatus,
    this.showListening,
    this.hideListening,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      medicines: store.state.medicineListState.medicines,
      queriedMedicines: store.state.medicineListState.queriedMedicines,
      isSearching: store.state.medicineListState.isSearching,
      isListening: store.state.medicineListState.isListening,
      isLoading: store.state.medicineListState.isLoading,
      loadingStatus: store.state.medicineListState.loadingStatus,
      showListening: () => store.dispatch(new ShowListening()),
      hideListening: () => store.dispatch(new HideListening()),
      onSearchClick: () => store.dispatch(new ToggleSearching()),
      onVoiceClicked: () => store.dispatch(new ToggleListening()),
      onQueryChanged: (String query) => store.dispatch(new MedicineListQueryAction(query)),
      onDispose: () => store.dispatch(new ResetStateAction()),
    );
  }
}
