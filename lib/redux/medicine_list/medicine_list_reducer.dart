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
  new TypedReducer<MedicineListState, ActivateSpeechRecognizer>(
    _activateSpeechRecognizer,
  ),
  new TypedReducer<MedicineListState, DeactivateSpeechRecognizer>(
    _deactivateSpeechRecognizer,
  ),
  new TypedReducer<MedicineListState, ResetStateAction>(
    _resetState,
  ),
]);

MedicineListState _fetchMedicinesRequested(
  MedicineListState state,
  FetchMedicineRequested action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

MedicineListState _fetchMedicinesSuccess(
  MedicineListState state,
  FetchMedicineSuccess action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    medicines: action.medicines,
  );
}

MedicineListState _fetchMedicinesError(
  MedicineListState state,
  FetchMedicinesError action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}

MedicineListState _toggleSearching(
  MedicineListState state,
  ToggleSearching action,
) {
  return state.copyWith(isSearching: !state.isSearching);
}

MedicineListState _activateSpeechRecognizer(
  MedicineListState state,
  ActivateSpeechRecognizer action,
) {
  return state.copyWith(isListening: true);
}

MedicineListState _deactivateSpeechRecognizer(
  MedicineListState state,
  DeactivateSpeechRecognizer action,
) {
  return state.copyWith(isListening: false);
}

MedicineListState _resetState(
  MedicineListState state,
  ResetStateAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.initial,
    isLoading: false,
    isListening: false,
    isSearching: false,
  );
}
