import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/data/model/pharmacy.dart';
import 'package:medical_app/redux/nearby_pharmacies/nearby_pharmacies_staet.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:medical_app/util/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPharmaciesScreen extends StatefulWidget {
  final Function(double lat, double lng) onLocationReady;
  final List<Pharmacy> pharmacies;
  final NearbyPharmacyScreenState state;

  NearbyPharmaciesScreen({
    this.onLocationReady,
    this.pharmacies,
    this.state,
  });

  @override
  NearbyPharmaciesScreenState createState() {
    return new NearbyPharmaciesScreenState();
  }
}

class NearbyPharmaciesScreenState extends State<NearbyPharmaciesScreen> with SingleTickerProviderStateMixin {
  TabController tabController;

  double lat = 18.8077942;
  double lng = 99.005631;

  Widget _buildPharmacyItem(Pharmacy pharmacy) {
    return ListTile(
      title: new Text(pharmacy.name),
      onTap: () => _openMapApplication(pharmacy),
    );
  }

  void _openMapApplication(Pharmacy pharmacy) async {
    String googleUrl = createGoogleMapUrl(pharmacy.lat, pharmacy.lng, pharmacy.name);
    String appleUrl = createAppleMapUrl(pharmacy.lat, pharmacy.lng, pharmacy.name);
    appleUrl = Uri.encodeFull(appleUrl);

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      await launch(appleUrl);
    } else {
      // throw 'Could not launch url';
    }
  }

  Widget _buildMapOptions(Pharmacy pharmacy) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 16.0),
        Text(pharmacy.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.title),
        SizedBox(height: 24.0),
        ListTile(
          leading: Icon(Icons.navigation),
          title: Text('เส้นทาง'),
          onTap: () => _openMapApplication(pharmacy),
        ),
      ],
    );
  }

  Marker _buildMarker(Pharmacy pharmacy) {
    return Marker(
      width: 45.0,
      height: 45.0,
      point: LatLng(pharmacy.lat, pharmacy.lng),
      builder: (context) => Container(
            child: IconButton(
              icon: Icon(Icons.location_on),
              color: Colors.red,
              iconSize: 45.0,
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) => _buildMapOptions(pharmacy));
              },
            ),
          ),
    );
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ร้านขายยา"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(Icons.map)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LoadingView(
            loadingStatus: widget.state.loadingStatus,
            loadingContent: LoadingContent(text: 'กำลังโหลด'),
            initialContent: ListView(
              children: widget.pharmacies.map((Pharmacy pharmacy) => _buildPharmacyItem(pharmacy)).toList(),
            ),
          ),
          FlutterMap(
            options: MapOptions(
              center: LatLng(lat, lng),
              minZoom: 5.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: createMapBoxUrl(),
                additionalOptions: {
                  'accessToken': Environment.mapBoxAccessToken,
                  'id': 'mapbox.mapbox-streets-v7',
                },
              ),
              MarkerLayerOptions(
                markers: widget.pharmacies.map((Pharmacy pharmacy) => _buildMarker(pharmacy)).toList(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
