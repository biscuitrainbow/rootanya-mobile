import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMedicineListMiddleware(
  MedicineRepository medicineRepository,
) {
  return [
    new TypedMiddleware<AppState, MedicineListQueryAction>(
      fetchMedicineByQuery(medicineRepository),
    ),
    new TypedMiddleware<AppState, LoadAllMedicineListAction>(
      fetchAllMedicine(medicineRepository),
    ),
  ];
}

Middleware<AppState> fetchAllMedicine(MedicineRepository medicineRepository) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadAllMedicineListAction) {
      try {
        var medicines = await medicineRepository.fetchAllMedicines();
        store.dispatch(new ReceivedMedicines(medicines));
      } catch (error) {
        print('error');
        print(error);
      }
    }
  };
}

Middleware<AppState> fetchMedicineByQuery(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is MedicineListQueryAction) {
      try {
        store.dispatch(new ShowLoading());
        var pharmacies = store.state.medicineListState.medicines.where((Medicine med) => med.barcode.contains(action.query) || med.name.contains(action.query) || med.category.contains(action.query) || med.type.contains(action.query) || med.fors.contains(action.query)).toList();

        if (action.query.isNotEmpty) {
          store.dispatch(new ReceivedQueryMedicines(pharmacies));
        } else {
          store.dispatch(new ReceivedQueryMedicines([]));
        }

        store.dispatch(new HideLoading());
      } catch (error) {
        print(error);
        store.dispatch(new HideLoading());
        store.dispatch(new ErrorLoadingAction());
      }
    }
  };
}
