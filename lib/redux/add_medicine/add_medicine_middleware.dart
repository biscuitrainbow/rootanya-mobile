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
      _addMedicine(medicineRepository),
    ),
  ];
}

Middleware<AppState> _addMedicine(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddMedicineAction) {
      var user = store.state.user;

      try {
        next(RequestAddMedicineAction());
        await medicineRepository.addMedicine(action.medicine, user.id);
        action.completer.complete(null);
        next(SuccessAddMedicineAction());
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}
