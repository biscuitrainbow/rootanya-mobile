import 'package:medical_app/data/model/pharmacy.dart';

class FetchNearbyPharmacies{
  final double lat;
  final double lng;

  FetchNearbyPharmacies(this.lat, this.lng);
}

class FetchNearbyPharmaciesSuccess{
  final List<Pharmacy> pharmacies;

  FetchNearbyPharmaciesSuccess(this.pharmacies);
}

class ShowNearbyPharmaciesLoading {

}

class HideNearbyPharmaciesLoading {

}