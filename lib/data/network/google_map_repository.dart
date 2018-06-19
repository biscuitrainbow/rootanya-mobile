import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:medical_app/data/model/pharmacy.dart';

class GoogleMapRepository {
  final GoogleMapsPlaces googleMapsPlaces;

  GoogleMapRepository(this.googleMapsPlaces);

  Future<List<Pharmacy>> getNearByPharmacies(double latitude, double longitude) async {
    var placeResponse = await googleMapsPlaces.searchNearbyWithRadius(
      new Location(latitude, longitude),
      5000,
      type: "pharmacy",
    );

    var pharmaciesPlace = placeResponse.results;
    var pharmacies = pharmaciesPlace
        .map(
          (r) => new Pharmacy(
                r.name,
                r.geometry.location.lat,
                r.geometry.location.lng,
              ),
        )
        .toList();

    return pharmacies;
  }
}
