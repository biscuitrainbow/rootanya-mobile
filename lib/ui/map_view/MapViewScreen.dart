import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/location.dart' as mv;
import 'package:google_maps_webservice/places.dart' as pc;
import 'package:geolocation/geolocation.dart';

class MapViewScreen extends StatelessWidget {
  void buildMap() async {
    try {
      LocationResult result = await Geolocation
          .currentLocation(accuracy: LocationAccuracy.best)
          .single;

      MapView mapView = new MapView();

      mapView.show(
        new MapOptions(
          title: "แผนที่ร้านขายยา",
          mapViewType: MapViewType.normal,
          showUserLocation: true,
          initialCameraPosition: new CameraPosition(
            new mv.Location(
                result.location.latitude, result.location.longitude),
            14.0,
          ),
        ),
        toolbarActions: [
          new ToolbarAction("Close", 1),
        ],
      );

      mapView.onMapReady.listen((_) async {
        var mapCenter = await mapView.centerLocation;

        var placeApi =
            new pc.GoogleMapsPlaces("AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w");

        var placeResponse = await placeApi.searchNearbyWithRadius(
          new pc.Location(mapCenter.latitude, mapCenter.longitude),
          5000,
          type: "pharmacy",
        );

        if (placeResponse.hasNoResults) {
          print("No results");
          return;
        }

        var results = placeResponse.results;
        var markers = results
            .map(
              (r) => new Marker(
                    r.id,
                    r.name,
                    r.geometry.location.lat,
                    r.geometry.location.lng,
                  ),
            )
            .toList();

        var currentMarkers = mapView.markers;

        var markersToAdd = markers.where((m) => !currentMarkers.contains(m));
        markersToAdd.forEach((m) => mapView.addMarker(m));
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    buildMap();

    return new Container();
  }
}
