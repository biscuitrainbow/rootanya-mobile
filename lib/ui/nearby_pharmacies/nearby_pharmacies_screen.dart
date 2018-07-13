import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:google_maps_webservice/places.dart' as pc;
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/models/location_accuracy.dart';
import 'package:geolocator/models/position.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPharmaciesScreen extends StatelessWidget {
  final Function(double lat, double lng) onLocationReady;
  final List<Pharmacy> pharmacies;

  const NearbyPharmaciesScreen({Key key, this.onLocationReady, this.pharmacies}) : super(key: key);

  void showMap(
    BuildContext context,
    double lat,
    double lng,
  ) async {
    try {
      MapView mapView = new MapView();

      mapView.show(
        new MapOptions(
          title: "แผนที่ร้านขายยา",
          mapViewType: MapViewType.normal,
          showUserLocation: true,
          initialCameraPosition: new CameraPosition(
            new Location(
              lat,
              lng,
            ),
            14.0,
          ),
        ),
        toolbarActions: [
          new ToolbarAction("Close", 1),
        ],
      );

      mapView.onToolbarAction.listen((id) {
        if (id == 1) {
          mapView.dismiss();
        }
      });

      mapView.onMapReady.listen((_) async {
        var mapCenter = await mapView.centerLocation;
        var placeApi = new pc.GoogleMapsPlaces("AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w");

        var placeResponse = await placeApi.searchNearbyWithRadius(
          new pc.Location(mapCenter.latitude, mapCenter.longitude),
          5000,
          type: "pharmacy",
        );

        if (placeResponse.hasNoResults) {
          print("No results");
          return;
        }

        var pharmacies = placeResponse.results;
        var markers = pharmacies
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

        var markersToAdd = markers.where((m) => !currentMarkers.contains(m)).toList();
        mapView.setMarkers(markersToAdd);
        // markersToAdd.forEach((m) => mapView.addMarker(m));
      });
    } catch (error) {
      print(error);
    }
  }

  List<ListTile> buildPharmacyItem(List<Pharmacy> pharmacies) {
    return pharmacies
        .map(
          (p) => new ListTile(
                title: new Text(p.name),
                onTap: () async {
                  String googleUrl = 'http://maps.google.com/maps?q= ${p.lat},${p.lng}(${p.name})&iwloc=A&hl=es';
                  await launch(googleUrl);
                },
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double lat = 18.8077942;
    double lng = 99.005631;

    new Geolocator().getPosition(LocationAccuracy.best).then(
          (Position position) => onLocationReady(
                position.latitude,
                position.longitude,
              ),
        );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ร้านขายยา"),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => showMap(context, lat, lng),
        child: new Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
      body: new ListView(
        children: buildPharmacyItem(pharmacies),
      ),
    );
  }
}
