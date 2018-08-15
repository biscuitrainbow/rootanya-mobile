import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/pharmacy.dart';

class NearbyPharmacyScreenState {
  NearbyPharmacyScreenState({
    this.pharmacies,
    this.loadingStatus,
  });

  factory NearbyPharmacyScreenState.initial() {
    return new NearbyPharmacyScreenState(
      pharmacies: [],
      loadingStatus: LoadingStatus.loading,
    );
  }

  final List<Pharmacy> pharmacies;
  final LoadingStatus loadingStatus;

  NearbyPharmacyScreenState copyWith({
    List<Pharmacy> pharmacies,
    LoadingStatus loadingStatus,
  }) {
    return new NearbyPharmacyScreenState(
      pharmacies: pharmacies ?? this.pharmacies,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is NearbyPharmacyScreenState && runtimeType == other.runtimeType && pharmacies == other.pharmacies;

  @override
  int get hashCode => pharmacies.hashCode;
}
