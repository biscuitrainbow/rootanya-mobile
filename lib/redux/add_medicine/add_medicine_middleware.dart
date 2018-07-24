import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAddMedicineMiddleware(
  MedicineRepository medicineRepository,
) {
  return [
    new TypedMiddleware<AppState, AddMedicineAction>(
      addMedicine(medicineRepository),
    ),
  ];
}

Middleware<AppState> addMedicine(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddMedicineAction) {
      try {
        var user = store.state.user;

        next(RequestAddMedicineAction());
        await medicineRepository.addMedicine(action.medicine, user.id);
        action.completer.complete(null);
        next(SuccessAddMedicineAction());
        store.dispatch(FetchAllMedicineAction());
      } catch (error) {
        print(error);
        next(SuccessAddMedicineAction());
      }
      next(action);
    }
  };
}
