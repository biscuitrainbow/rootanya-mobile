import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:redux/redux.dart';

final nearbyPharmaciesReducer = combineReducers<NearbyPharmacyState>([
  new TypedReducer<NearbyPharmacyState, FetchNearbyPharmaciesSuccess>(
    _fetchNearbyPharmaciesSuccess,
  )
]);

NearbyPharmacyState _fetchNearbyPharmaciesSuccess(
  NearbyPharmacyState state,
  FetchNearbyPharmaciesSuccess action,
) {
  return state.copyWith(
    pharmacies: action.pharmacies,
  );
}
