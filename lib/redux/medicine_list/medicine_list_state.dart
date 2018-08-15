import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/loading_status.dart';

class MedicineListScreenState {
  final List<Medicine> medicines;
  final bool isSearching;
  final bool isListening;
  final LoadingStatus loadingStatus;

  MedicineListScreenState({
    this.medicines,
    this.isSearching,
    this.isListening,
    this.loadingStatus,
  });

  factory MedicineListScreenState.initial() {
    return new MedicineListScreenState(
      medicines: [],
      loadingStatus: LoadingStatus.initial,
      isSearching: false,
      isListening: false,
    );
  }

  MedicineListScreenState copyWith({
    List<Medicine> medicines,
    bool isSearching,
    bool isListening,
    bool isLoading,
    LoadingStatus loadingStatus,
  }) {
    return new MedicineListScreenState(
      medicines: medicines ?? this.medicines,
      isSearching: isSearching ?? this.isSearching,
      isListening: isListening ?? this.isListening,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
