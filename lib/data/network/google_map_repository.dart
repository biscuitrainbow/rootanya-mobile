import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:medical_app/data/model/pharmacy.dart';

class GoogleMapRepository {
  final GoogleMapsPlaces googleMapsPlaces;

  GoogleMapRepository(this.googleMapsPlaces);

  Future<List<Pharmacy>> getNearByPharmacies(double latitude, double longitude) async {
    var placeResponse = await googleMapsPlaces.searchNearbyWithRankBy(
      new Location(latitude, longitude),
      'distance',
      type: "pharmacy",
    );

    var pharmaciesPlace = placeResponse.results;
    print(pharmaciesPlace[0].openingHours);

    var pharmacies = pharmaciesPlace
        .map(
          (r) => new Pharmacy(
                r.name,
                r.geometry.location.lat,
                r.geometry.location.lng,
                false,
              ),
        )
        .toList();

    return pharmacies;
  }
}
