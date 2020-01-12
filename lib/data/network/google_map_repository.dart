import 'dart:async';

import 'package:google_maps_webservice/places.dart';
import 'package:rootanya/data/model/pharmacy.dart';

class GoogleMapRepository {
  final GoogleMapsPlaces googleMapsPlaces;

  GoogleMapRepository(this.googleMapsPlaces);

  Future<List<Pharmacy>> getNearByPharmacies(double latitude, double longitude) async {
    var placeResponse = await googleMapsPlaces.searchNearbyWithRankBy(
      Location(latitude, longitude),
      'distance',
      type: "pharmacy",
      // language: 'th',
    );

    print(placeResponse.errorMessage);

    var pharmaciesPlace = placeResponse.results;
    var pharmacies = pharmaciesPlace
        .map(
          (response) => new Pharmacy(
                response.name,
                response.geometry.location.lat,
                response.geometry.location.lng,
                false,
              ),
        )
        .toList();

    return pharmacies;
  }
}
