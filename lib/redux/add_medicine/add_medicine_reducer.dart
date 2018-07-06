import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_state.dart';
import 'package:redux/redux.dart';

final addMedicineReducer = combineReducers<AddMedicineState>([
  new TypedReducer<AddMedicineState, RequestAddMedicineAction>(
    showLoading,
  ),
  new TypedReducer<AddMedicineState, SuccessAddMedicineAction>(
    successLoading,
  )
]);

AddMedicineState showLoading(
  AddMedicineState state,
  RequestAddMedicineAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

AddMedicineState successLoading(
  AddMedicineState state,
  SuccessAddMedicineAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.success);
}
