import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/loading_status.dart';

class MedicineListState {
  final List<Medicine> medicines;
  final bool isSearching;
  final bool isListening;
  final LoadingStatus loadingStatus;

  MedicineListState({
    this.medicines,
    this.isSearching,
    this.isListening,
    this.loadingStatus,
  });

  factory MedicineListState.initial() {
    return new MedicineListState(
      medicines: [],
      loadingStatus: LoadingStatus.initial,
      isSearching: false,
      isListening: false,
    );
  }

  MedicineListState copyWith({
    List<Medicine> medicines,
    bool isSearching,
    bool isListening,
    bool isLoading,
    LoadingStatus loadingStatus,
  }) {
    return new MedicineListState(
      medicines: medicines ?? this.medicines,
      isSearching: isSearching ?? this.isSearching,
      isListening: isListening ?? this.isListening,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
