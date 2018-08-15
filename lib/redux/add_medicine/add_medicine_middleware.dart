import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAddMedicineMiddleware(
  MedicineRepository medicineRepository,
) {
  return [
    new TypedMiddleware<AppState, AddMedicineAction>(
      _addMedicine(medicineRepository),
    ),
  ];
}

Middleware<AppState> _addMedicine(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddMedicineAction) {
      next(ShowAddMedicineLoadingAction());

      try {
        var token = store.state.token;
        await medicineRepository.addMedicine(action.medicine, token);

        action.completer.complete(null);
      } catch (error) {
        print(error);
      }

      next(HideAddMedicineLoadingAction());
      next(action);
    }
  };
}
