import 'package:medical_app/data/model/pharmacy.dart';

class FetchNearbyPharmaciesAction{
  final double lat;
  final double lng;

  FetchNearbyPharmaciesAction(this.lat, this.lng);
}

class ReceivedPharmaciesAction{
  final List<Pharmacy> pharmacies;

  ReceivedPharmaciesAction(this.pharmacies);
}