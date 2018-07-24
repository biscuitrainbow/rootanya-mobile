import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:location/location.dart' as libLocation;
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_action.dart';
import 'package:medical_app/ui/nearby_pharmacies/nearby_pharmacies_screen.dart';
import 'package:redux/redux.dart';

class NearbyPharmaciesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      onInit: (Store<AppState> store) async {
        var location = new libLocation.Location();
        try {
          var currentLocation = await location.getLocation;
          store.dispatch(new FetchNearbyPharmaciesAction(currentLocation["latitude"].toDouble(), currentLocation["longitude"].toDouble()));
        } catch (error) {
          print(error);
        }
      },
      distinct: true,
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return new NearbyPharmaciesScreen(
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
    return new ViewModel(
      pharmacies: store.state.nearbyPharmacyState.pharmacies,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is ViewModel && runtimeType == other.runtimeType && pharmacies == other.pharmacies && onLocationReady == other.onLocationReady;

  @override
  int get hashCode => pharmacies.hashCode ^ onLocationReady.hashCode;
}
