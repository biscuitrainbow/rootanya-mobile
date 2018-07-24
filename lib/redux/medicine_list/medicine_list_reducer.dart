import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:redux/redux.dart';

final medicineListReducer = combineReducers<MedicineListState>([
  new TypedReducer<MedicineListState, ReceivedMedicines>(
    receivedMedicines,
  ),
  new TypedReducer<MedicineListState, ReceivedQueryMedicines>(
    receivedQueryMedicines,
  ),
  new TypedReducer<MedicineListState, ToggleSearching>(
    toggleSearching,
  ),
  new TypedReducer<MedicineListState, ToggleListening>(
    toggleListening,
  ),
  new TypedReducer<MedicineListState, ResetStateAction>(
    resetState,
  ),
  new TypedReducer<MedicineListState, ShowLoading>(
    showLoading,
  ),
  new TypedReducer<MedicineListState, HideLoading>(
    hideLoading,
  ),
  new TypedReducer<MedicineListState, ShowListening>(
    showListening,
  ),
  new TypedReducer<MedicineListState, HideListening>(
    hideListening,
  ),
  new TypedReducer<MedicineListState, ErrorLoadingAction>(
    errorLoading,
  )
]);

MedicineListState receivedMedicines(
  MedicineListState state,
  ReceivedMedicines action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    medicines: action.medicines,
  );
}

MedicineListState receivedQueryMedicines(
  MedicineListState state,
  ReceivedQueryMedicines action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    queriedMedicine: action.medicines,
  );
}

MedicineListState toggleSearching(
  MedicineListState state,
  ToggleSearching action,
) {
  return state.copyWith(
    isSearching: !state.isSearching,
  );
}

MedicineListState toggleListening(
  MedicineListState state,
  ToggleListening action,
) {
  return state.copyWith(
    isListening: !state.isListening,
  );
}

MedicineListState showListening(
  MedicineListState state,
  ShowListening action,
) {
  return state.copyWith(
    isListening: true,
  );
}

MedicineListState hideListening(
  MedicineListState state,
  HideListening action,
) {
  return state.copyWith(
    isListening: false,
  );
}

MedicineListState errorLoading(
  MedicineListState state,
  ErrorLoadingAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}

MedicineListState resetState(
  MedicineListState state,
  ResetStateAction action,
) {
  return state.copyWith(
    queriedMedicine: [],
    loadingStatus: LoadingStatus.initial,
    isLoading: false,
    isListening: false,
    isSearching: false,
  );
}

MedicineListState showLoading(
  MedicineListState state,
  ShowLoading action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

MedicineListState hideLoading(
  MedicineListState state,
  HideLoading action,
) {
  return state.copyWith(isLoading: false);
}
