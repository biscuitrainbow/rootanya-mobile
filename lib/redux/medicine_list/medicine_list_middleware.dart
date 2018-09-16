import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMedicineMiddleware(
  MedicineRepository medicineRepository,
) {
  return [
    TypedMiddleware<AppState, FetchAllMedicine>(
      _fetchAllMedicine(medicineRepository),
    ),
    TypedMiddleware<AppState, FetchMedicineByQuery>(
      _fetchMedicineByQuery(medicineRepository),
    ),
  ];
}

Middleware<AppState> _fetchAllMedicine(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchAllMedicine) {
      try {
        final token = store.state.token;
        final medicines = await medicineRepository.fetchAllMedicines(token);

        next(FetchMedicineSuccess(medicines));
      } catch (error) {
        print(error);
      }
    }
  };
}

Middleware<AppState> _fetchMedicineByQuery(
  MedicineRepository medicineRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchMedicineByQuery) {
      //next(FetchMedicineRequested());

      try {
        final medicines = store.state.medicineListState.medicines;

        if (action.query.isNotEmpty) {
          final queriedMedicines = medicines.where((Medicine medicine) {
            return medicine.barcode.contains(action.query) || medicine.name.contains(action.query) || medicine.category.contains(action.query) || medicine.type.contains(action.query);
          }).toList();
          //   print('queried length : ${queriedMedicines.length}');
          next(FetchQueriedMedicineSuccess(queriedMedicines));
        } else {
          //   print('all length : ${medicines.length}');
          next(FetchQueriedMedicineSuccess(medicines));
        }
      } catch (error) {
        print(error);
        // next(FetchMedicinesError());
      }
    }
  };
}

//Middleware<AppState> _fetchMedicineByQuery(
//  MedicineRepository medicineRepository,
//) {
//  return (Store<AppState> store, action, NextDispatcher next) async {
//    if (action is FetchMedicineByQuery) {
//      next(FetchMedicineRequested());
//
//      try {
//        var token = store.state.token;
//
//        var medicines = await medicineRepository.fetchMedicineByQuery(action.query, token);
//        next(FetchMedicineSuccess(medicines));
//      } catch (error) {
//        print(error);
//        next(FetchMedicinesError());
//      }
//    }
//  };
//}
