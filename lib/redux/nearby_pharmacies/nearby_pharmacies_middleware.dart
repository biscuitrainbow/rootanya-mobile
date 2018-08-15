import 'package:medical_app/data/network/google_map_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createNearbyPharmaciesMiddleware(
  GoogleMapRepository googleMapRepository,
) {
  return [
    new TypedMiddleware<AppState, FetchNearbyPharmacies>(
      _fetchNearbyPharmacies(googleMapRepository),
    ),
  ];
}

Middleware<AppState> _fetchNearbyPharmacies(
  GoogleMapRepository googleMapRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchNearbyPharmacies) {
      try {
        store.dispatch(ShowNearbyPharmaciesLoading());
        var pharmacies = await googleMapRepository.getNearByPharmacies(action.lat, action.lng);
        next(new FetchNearbyPharmaciesSuccess(pharmacies));
      } catch (error) {
        print(error);
      }

      next(HideNearbyPharmaciesLoading());
      next(action);
    }
  };
}
