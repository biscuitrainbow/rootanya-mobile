import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
//      onInit: (Store store) =>
//          store.dispatch(new MedicineListQueryAction('พารา')),
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        print(vm.isLoading);

        return new MedicineListScreen(
          medicines: vm.medicines,
          isSearching: vm.isSearching,
          isListening: vm.isListening,
          isLoading: vm.isLoading,
          onSearchClick: vm.onSearchClick,
          onVoiceClicked: vm.onVoiceClicked,
          onDispose: vm.onDispose,
          queryController: queryController,
          onSearchQueryChanged: vm.onQueryChanged,
        );
      },
    );
  }
}

class ViewModel {
  final List<Medicine> medicines;
  final bool isSearching;
  final bool isListening;
  final bool isLoading;
  final Function onSearchClick;
  final Function(String) onQueryChanged;
  final Function onVoiceClicked;
  final Function onDispose;

  ViewModel({
    this.medicines,
    this.isSearching,
    this.isListening,
    this.isLoading,
    this.onSearchClick,
    this.onVoiceClicked,
    this.onQueryChanged,
    this.onDispose,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      medicines: store.state.medicineListState.medicines,
      isSearching: store.state.medicineListState.isSearching,
      isListening: store.state.medicineListState.isListening,
      isLoading: store.state.medicineListState.isLoading,
      onSearchClick: () => store.dispatch(new ToggleSearching()),
      onVoiceClicked: () => store.dispatch(new ToggleListening()),
      onQueryChanged: (String query) =>
          store.dispatch(new MedicineListQueryAction(query)),
      onDispose: () => store.dispatch(new ResetStateAction()),
    );
  }
}
