import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_state.dart';
import 'package:redux/redux.dart';

final medicineListReducer = combineReducers<MedicineListScreenState>([
  TypedReducer<MedicineListScreenState, FetchMedicineRequested>(
    _fetchMedicinesRequested,
  ),
  TypedReducer<MedicineListScreenState, FetchMedicineSuccess>(
    _fetchMedicinesSuccess,
  ),
  TypedReducer<MedicineListScreenState, FetchQueriedMedicineSuccess>(
    _fetchQueriedMedicinesSuccess,
  ),
  TypedReducer<MedicineListScreenState, FetchMedicinesError>(
    _fetchMedicinesError,
  ),
  TypedReducer<MedicineListScreenState, ToggleSearching>(
    _toggleSearching,
  ),
  TypedReducer<MedicineListScreenState, ActivateSpeechRecognizer>(
    _activateSpeechRecognizer,
  ),
  TypedReducer<MedicineListScreenState, DeactivateSpeechRecognizer>(
    _deactivateSpeechRecognizer,
  ),
  TypedReducer<MedicineListScreenState, ResetStateAction>(
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

MedicineListScreenState _fetchQueriedMedicinesSuccess(
  MedicineListScreenState state,
  FetchQueriedMedicineSuccess action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    queriedMedicines: action.medicines,
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
