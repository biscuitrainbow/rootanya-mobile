import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart' as libLocation;
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:map_view/map_view.dart';

class NearbyPharmaciesScreen extends StatefulWidget {
  final Function(double lat, double lng) onLocationReady;
  final List<Pharmacy> pharmacies;
  final NearbyPharmacyScreenState state;

  NearbyPharmaciesScreen({
    Key key,
    this.onLocationReady,
    this.pharmacies,
    this.state,
  }) : super(key: key);

  @override
  NearbyPharmaciesScreenState createState() {
    return new NearbyPharmaciesScreenState();
  }
}

class NearbyPharmaciesScreenState extends State<NearbyPharmaciesScreen> {
  List<ListTile> buildPharmacyItem(List<Pharmacy> pharmacies) {
    return pharmacies
        .map(
          (p) => new ListTile(
                title: new Text(p.name),
                //  subtitle: Text(p.isOpening.toString()),
                onTap: () async {
                  String googleUrl = 'http://maps.google.com/maps?q= ${p.lat},${p.lng}(${p.name})&iwloc=A&hl=es';

                  var sanitizer = const HtmlEscape();

                  String appleUrl = 'maps://maps.apple.com/?ll=${p.lat},${p.lng}&z=5&q=${p.name}';
                  appleUrl = Uri.encodeFull(appleUrl);
                  print(appleUrl);
                  if (await canLaunch(googleUrl)) {
                    print('launching com googleUrl');
                    await launch(googleUrl);
                  } else if (await canLaunch(appleUrl)) {
                    print('launching apple url');
                    await launch(appleUrl);
                  } else {
                    // throw 'Could not launch url';
                  }
                },
              ),
        )
        .toList();
  }

//  List<MarkerOptions> markers = [];

  libLocation.Location location = libLocation.Location();
  GoogleMapsPlaces placeApi = new GoogleMapsPlaces("AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w");

  double lat = 18.8077942;
  double lng = 99.005631;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.state.loadingStatus);

//    final GoogleMapOverlayController controller = GoogleMapOverlayController.fromSize(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height);
//    controller.mapController.animateCamera(CameraUpdate.newCameraPosition(
//      CameraPosition(
//        target: LatLng(lat, lng),
//        tilt: 30.0,
//        zoom: 12.0,
//      ),
//    ));
//
//    final Widget mapWidget = GoogleMapOverlay(controller: controller);
//
//    location.getLocation.then((Map<String, double> currentLocation) {
//      placeApi.searchNearbyWithRadius(Location(currentLocation["latitude"].toDouble(), currentLocation["longitude"].toDouble()), 5000, type: "pharmacy").then((placeResponse) {
//        if (placeResponse.hasNoResults) {
//          print("No results");
//          return;
//        }
//
//        var pharmacies = placeResponse.results;
//
//        pharmacies.forEach(
//          (pharmacy) => controller.mapController.addMarker(
//                MarkerOptions(
//                  position: LatLng(
//                    pharmacy.geometry.location.lat,
//                    pharmacy.geometry.location.lng,
//                  ),
//                ),
//              ),
//        );
//      });
//    });

    return Scaffold(
      appBar: AppBar(
        title: new Text("ร้านขายยา"),
      ),
      body: LoadingView(
        loadingStatus: widget.state.loadingStatus,
        loadingContent: LoadingContent(text: 'กำลังโหลด'),
//        initialContent: ListView(
//          children: buildPharmacyItem(widget.pharmacies),
//        ),
        initialContent: new FlutterMap(options: new MapOptions(center: new LatLng(lat, lng), minZoom: 5.0), layers: [
          new TileLayerOptions(urlTemplate: "https://api.mapbox.com/styles/v1/rajayogan/cjl1bndoi2na42sp2pfh2483p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFqYXlvZ2FuIiwiYSI6ImNqNW1nOXhtMTNndXkyeG5xbDZiNzZmaGcifQ.S5sdpVrOr2pa5oRqvWDMGA", additionalOptions: {'accessToken': 'pk.eyJ1IjoicmFqYXlvZ2FuIiwiYSI6ImNqNW1nOXhtMTNndXkyeG5xbDZiNzZmaGcifQ.S5sdpVrOr2pa5oRqvWDMGA', 'id': 'mapbox.mapbox-streets-v7'}),
          new MarkerLayerOptions(markers: [
            new Marker(
                width: 45.0,
                height: 45.0,
                point: new LatLng(lat, lng),
                builder: (context) => new Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () {
                          print('Marker tapped');
                        },
                      ),
                    ))
          ])
        ]),
      ),
    );

//    return DefaultTabController(
//      length: 2,
//      child: new Scaffold(
//        appBar: new AppBar(
//          title: new Text("ร้านขายยา"),
//          bottom: TabBar(
//            tabs: <Widget>[
//              Tab(icon: Icon(Icons.list)),
//              Tab(icon: Icon(Icons.map)),
//            ],
//          ),
//        ),
//        body: TabBarView(children: [
//          ListView(
//            children: buildPharmacyItem(widget.pharmacies),
//          ),
//          Center(
//            child: mapWidget,
//          ),
//        ]),
////      body:
//      ),
//    );
  }
}
