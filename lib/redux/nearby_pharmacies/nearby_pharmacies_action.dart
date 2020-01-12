import 'package:rootanya/data/model/pharmacy.dart';

class FetchNearbyPharmacies{
}

class FetchNearbyPharmaciesSuccess{
  final List<Pharmacy> pharmacies;

  FetchNearbyPharmaciesSuccess(this.pharmacies);
}

class ShowNearbyPharmaciesLoading {

}

class HideNearbyPharmaciesLoading {

}