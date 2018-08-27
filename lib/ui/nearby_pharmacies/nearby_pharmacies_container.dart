import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/ui/nearby_pharmacies/nearby_pharmacies_screen.dart';
import 'package:redux/redux.dart';

class NearbyPharmaciesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      onInit: (Store<AppState> store) => store.dispatch(FetchNearbyPharmacies()),
      distinct: true,
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return NearbyPharmaciesScreen(
          state: vm.state,
          pharmacies: vm.pharmacies,
        );
      },
    );
  }
}

class ViewModel {
  final List<Pharmacy> pharmacies;
  final NearbyPharmacyScreenState state;
  final Function(double lat, double lng) onLocationReady;

  ViewModel({
    this.state,
    this.pharmacies,
    this.onLocationReady,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      state: store.state.nearbyPharmacyState,
      pharmacies: store.state.nearbyPharmacyState.pharmacies,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is ViewModel && runtimeType == other.runtimeType && pharmacies == other.pharmacies && onLocationReady == other.onLocationReady;

  @override
  int get hashCode => pharmacies.hashCode ^ onLocationReady.hashCode;
}
