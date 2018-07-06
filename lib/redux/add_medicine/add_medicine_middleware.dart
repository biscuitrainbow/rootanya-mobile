import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
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
  return (Store store, action, NextDispatcher next) async {
    if (action is AddMedicineAction) {
      try {
        next(new RequestAddMedicineAction());
        await medicineRepository.addMedicine(action.medicine);
        next(new SuccessAddMedicineAction());
      } catch (error) {
        print(error);
        next(new SuccessAddMedicineAction());
      }
      next(action);
    }
  };
}
