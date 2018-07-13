import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/loading_status.dart';

class MedicineListState {
  final List<Medicine> medicines;
  final List<Medicine> queriedMedicines;

  final bool isSearching;
  final bool isListening;
  final bool isLoading;
  final LoadingStatus loadingStatus;

  MedicineListState({
    this.queriedMedicines,
    this.medicines,
    this.isSearching,
    this.isListening,
    this.isLoading,
    this.loadingStatus,
  });

  factory MedicineListState.initial() {
    return new MedicineListState(
      queriedMedicines: [],
      medicines: [],
      isSearching: true,
      isListening: false,
      isLoading: false,
      loadingStatus: LoadingStatus.initial,
    );
  }

  MedicineListState copyWith({
    List<Medicine> queriedMedicine,
    List<Medicine> medicines,
    bool isSearching,
    bool isListening,
    bool isLoading,
    LoadingStatus loadingStatus,
  }) {
    return new MedicineListState(
      queriedMedicines: queriedMedicine ?? this.queriedMedicines,
      medicines: medicines ?? this.medicines,
      isSearching: isSearching ?? this.isSearching,
      isListening: isListening ?? this.isListening,
      isLoading: isLoading ?? this.isLoading,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
