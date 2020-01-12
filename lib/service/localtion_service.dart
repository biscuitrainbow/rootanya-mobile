import 'dart:async';

import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<LatLng> getCurrentLocation() async {
    final currentLocation = await location.getLocation();

    return LatLng(
      currentLocation.latitude,
      currentLocation.longitude,
    );
  }
}
