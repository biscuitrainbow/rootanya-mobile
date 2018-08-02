import 'package:medical_app/data/model/pharmacy.dart';

class NearbyPharmacyState {
  NearbyPharmacyState({this.pharmacies});

  factory NearbyPharmacyState.initial() {
    return new NearbyPharmacyState(
      pharmacies: [],
    );
  }

  final List<Pharmacy> pharmacies;

  NearbyPharmacyState copyWith({
    List<Pharmacy> pharmacies,
  }) {
    return new NearbyPharmacyState(
      pharmacies: pharmacies ?? this.pharmacies,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is NearbyPharmacyState && runtimeType == other.runtimeType && pharmacies == other.pharmacies;

  @override
  int get hashCode => pharmacies.hashCode;
}
