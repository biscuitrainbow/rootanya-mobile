import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:redux/redux.dart';

final nearbyPharmaciesReducer = combineReducers<NearbyPharmacyScreenState>([
  new TypedReducer<NearbyPharmacyScreenState, FetchNearbyPharmaciesSuccess>(
    _fetchNearbyPharmaciesSuccess,
  ),
  new TypedReducer<NearbyPharmacyScreenState, ShowNearbyPharmaciesLoading>(
    _showLoading,
  ),
  new TypedReducer<NearbyPharmacyScreenState, HideNearbyPharmaciesLoading>(
    _hideLoading,
  )
]);

NearbyPharmacyScreenState _fetchNearbyPharmaciesSuccess(
  NearbyPharmacyScreenState state,
  FetchNearbyPharmaciesSuccess action,
) {
  return state.copyWith(
    pharmacies: action.pharmacies,
  );
}

NearbyPharmacyScreenState _showLoading(
  NearbyPharmacyScreenState state,
  ShowNearbyPharmaciesLoading action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

NearbyPharmacyScreenState _hideLoading(
  NearbyPharmacyScreenState state,
  HideNearbyPharmaciesLoading action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.initial,
  );
}
