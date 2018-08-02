import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_state.dart';
import 'package:redux/redux.dart';

final medicineListReducer = combineReducers<MedicineListState>([
  new TypedReducer<MedicineListState, FetchMedicineRequested>(
    _fetchMedicinesRequested,
  ),
  new TypedReducer<MedicineListState, FetchMedicineSuccess>(
    _fetchMedicinesSuccess,
  ),
  new TypedReducer<MedicineListState, FetchMedicinesError>(
    _fetchMedicinesError,
  ),
  new TypedReducer<MedicineListState, ToggleSearching>(
    _toggleSearching,
  ),
  new TypedReducer<MedicineListState, ToggleListening>(
    _toggleListening,
  ),
  new TypedReducer<MedicineListState, ResetStateAction>(
    _resetState,
  ),
  new TypedReducer<MedicineListState, ShowListening>(
    _showListening,
  ),
  new TypedReducer<MedicineListState, HideListening>(
    hideListening,
  ),
]);

MedicineListState _fetchMedicinesSuccess(
  MedicineListState state,
  FetchMedicineSuccess action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    medicines: action.medicines,
  );
}

MedicineListState _toggleSearching(
  MedicineListState state,
  ToggleSearching action,
) {
  return state.copyWith(
    isSearching: !state.isSearching,
  );
}

MedicineListState _toggleListening(
  MedicineListState state,
  ToggleListening action,
) {
  return state.copyWith(
    isListening: !state.isListening,
  );
}

MedicineListState _showListening(
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

MedicineListState _fetchMedicinesError(
  MedicineListState state,
  FetchMedicinesError action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}

MedicineListState _resetState(
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

MedicineListState _fetchMedicinesRequested(
  MedicineListState state,
  FetchMedicineRequested action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}
