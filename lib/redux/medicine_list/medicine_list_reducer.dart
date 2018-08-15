import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_state.dart';
import 'package:redux/redux.dart';

final medicineListReducer = combineReducers<MedicineListScreenState>([
  new TypedReducer<MedicineListScreenState, FetchMedicineRequested>(
    _fetchMedicinesRequested,
  ),
  new TypedReducer<MedicineListScreenState, FetchMedicineSuccess>(
    _fetchMedicinesSuccess,
  ),
  new TypedReducer<MedicineListScreenState, FetchMedicinesError>(
    _fetchMedicinesError,
  ),
  new TypedReducer<MedicineListScreenState, ToggleSearching>(
    _toggleSearching,
  ),
  new TypedReducer<MedicineListScreenState, ActivateSpeechRecognizer>(
    _activateSpeechRecognizer,
  ),
  new TypedReducer<MedicineListScreenState, DeactivateSpeechRecognizer>(
    _deactivateSpeechRecognizer,
  ),
  new TypedReducer<MedicineListScreenState, ResetStateAction>(
    _resetState,
  ),
]);

MedicineListScreenState _fetchMedicinesRequested(
  MedicineListScreenState state,
  FetchMedicineRequested action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

MedicineListScreenState _fetchMedicinesSuccess(
  MedicineListScreenState state,
  FetchMedicineSuccess action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    medicines: action.medicines,
  );
}

MedicineListScreenState _fetchMedicinesError(
  MedicineListScreenState state,
  FetchMedicinesError action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}

MedicineListScreenState _toggleSearching(
  MedicineListScreenState state,
  ToggleSearching action,
) {
  return state.copyWith(isSearching: !state.isSearching);
}

MedicineListScreenState _activateSpeechRecognizer(
  MedicineListScreenState state,
  ActivateSpeechRecognizer action,
) {
  return state.copyWith(isListening: true);
}

MedicineListScreenState _deactivateSpeechRecognizer(
  MedicineListScreenState state,
  DeactivateSpeechRecognizer action,
) {
  return state.copyWith(isListening: false);
}

MedicineListScreenState _resetState(
  MedicineListScreenState state,
  ResetStateAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.initial,
    isLoading: false,
    isListening: false,
    isSearching: false,
  );
}
