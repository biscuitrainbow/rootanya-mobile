import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/medicine.dart';

class MedicineListScreenState {
  final List<Medicine> medicines;
  final List<Medicine> queriedMedicines;

  final bool isSearching;
  final bool isListening;
  final LoadingStatus loadingStatus;

  MedicineListScreenState({
    this.medicines,
    this.queriedMedicines,
    this.isSearching,
    this.isListening,
    this.loadingStatus,
  });

  factory MedicineListScreenState.initial() {
    return new MedicineListScreenState(
      medicines: [],
      queriedMedicines: [],
      loadingStatus: LoadingStatus.initial,
      isSearching: false,
      isListening: false,
    );
  }

  MedicineListScreenState copyWith({
    List<Medicine> medicines,
    List<Medicine> queriedMedicines,
    bool isSearching,
    bool isListening,
    bool isLoading,
    LoadingStatus loadingStatus,
  }) {
    return new MedicineListScreenState(
      medicines: medicines ?? this.medicines,
      queriedMedicines: queriedMedicines ?? this.queriedMedicines,
      isSearching: isSearching ?? this.isSearching,
      isListening: isListening ?? this.isListening,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
