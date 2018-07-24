import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMedicineMiddleware(
  MedicineRepository medicineRepository,
) {
  return [
    TypedMiddleware<AppState, FetchMedicineByQueryAction>(
      _fetchMedicineByQuery(medicineRepository),
    ),
    TypedMiddleware<AppState, FetchAllMedicineAction>(
      _fetchAllMedicine(medicineRepository),
    ),
  ];
}

Middleware<AppState> _fetchAllMedicine(MedicineRepository medicineRepository) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchAllMedicineAction) {
      try {
        var user = store.state.user;
        var medicines = await medicineRepository.fetchAllMedicines(user.id);

        next(ReceivedMedicines(medicines));
      } catch (error) {
        print(error.toString());
      }
    }
  };
}

Middleware<AppState> _fetchMedicineByQuery(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchMedicineByQueryAction) {
      try {
        next(ShowLoading());
        var medicines = await medicineRepository.fetchMedicineByQuery(action.query);
        next(ReceivedQueryMedicines(medicines));
        next(HideLoading());
      } catch (error) {
        print(error);
        next(HideLoading());
        next(ErrorLoadingAction());
      }
    }
  };
}
