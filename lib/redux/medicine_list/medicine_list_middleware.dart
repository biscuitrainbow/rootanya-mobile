import 'package:medical_app/data/network/google_map_repository.dart';
import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMedicineListMiddleware(
  MedicineRepository medicineRepository,
) {
  return [
    new TypedMiddleware<AppState, MedicineListQueryAction>(
      fetchMedicineByQuery(medicineRepository),
    ),
  ];
}

Middleware<AppState> fetchMedicineByQuery(
  MedicineRepository medicineRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is MedicineListQueryAction) {
      try {
        store.dispatch(new ShowLoading());

        var pharmacies = await medicineRepository.fetchMedicineByQuery(action.query);
        store.dispatch(new ReceivedMedicines(pharmacies));

        store.dispatch(new HideLoading());
      } catch (error) {
        store.dispatch(new HideLoading());
        print(error);
      }
    }
  };
}
