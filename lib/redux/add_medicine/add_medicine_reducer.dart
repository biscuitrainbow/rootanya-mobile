import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/add_medicine/add_medicine_action.dart';
import 'package:rootanya/redux/add_medicine/add_medicine_state.dart';
import 'package:redux/redux.dart';

final addMedicineReducer = combineReducers<AddMedicineScreenState>([
  new TypedReducer<AddMedicineScreenState, ShowAddMedicineLoadingAction>(
    showLoading,
  ),
  new TypedReducer<AddMedicineScreenState, HideAddMedicineLoadingAction>(
    successLoading,
  )
]);

AddMedicineScreenState showLoading(
  AddMedicineScreenState state,
  ShowAddMedicineLoadingAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

AddMedicineScreenState successLoading(
  AddMedicineScreenState state,
  HideAddMedicineLoadingAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.success);
}
