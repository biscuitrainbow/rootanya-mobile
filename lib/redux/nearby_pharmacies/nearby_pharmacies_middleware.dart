import 'package:medical_app/data/network/google_map_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/service/localtion_service.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createNearbyPharmaciesMiddleware(
  GoogleMapRepository googleMapRepository,
  LocationService locationService,
) {
  return [
    new TypedMiddleware<AppState, FetchNearbyPharmacies>(
      _fetchNearbyPharmacies(googleMapRepository, locationService),
    ),
  ];
}

Middleware<AppState> _fetchNearbyPharmacies(
  GoogleMapRepository googleMapRepository,
  LocationService locationService,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchNearbyPharmacies) {
      try {
        store.dispatch(ShowNearbyPharmaciesLoading());
        final location = await locationService.getCurrentLocation();

        print(location);
        final pharmacies = await googleMapRepository.getNearByPharmacies(location.latitude, location.longitude);

        next(FetchNearbyPharmaciesSuccess(pharmacies));
      } catch (error) {
        print(error);
      }

      next(HideNearbyPharmaciesLoading());
      next(action);
    }
  };
}
