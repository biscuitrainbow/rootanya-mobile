import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/ui/nearby_pharmacies/nearby_pharmacies_screen.dart';
import 'package:redux/redux.dart';

class NearbyPharmaciesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      distinct: true,
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new NearbyPharmaciesScreen(
          onLocationReady: vm.onLocationReady,
          pharmacies: vm.pharmacies,
        );
      },
    );
  }
}


class ViewModel {
  final List<Pharmacy> pharmacies;
  final Function(double lat, double lng) onLocationReady;

  ViewModel({this.pharmacies, this.onLocationReady});

  static ViewModel fromStore(Store<AppState> store) {
    print(store.state.nearbyPharmacyState.pharmacies);

    return new ViewModel(
        pharmacies: store.state.nearbyPharmacyState.pharmacies,
        onLocationReady: (double lat,double lng) => store.dispatch(new FetchNearbyPharmaciesAction(lat, lng)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ViewModel &&
              runtimeType == other.runtimeType &&
              pharmacies == other.pharmacies &&
              onLocationReady == other.onLocationReady;

  @override
  int get hashCode =>
      pharmacies.hashCode ^
      onLocationReady.hashCode;




}

