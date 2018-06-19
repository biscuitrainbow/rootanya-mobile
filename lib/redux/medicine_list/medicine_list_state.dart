import 'package:medical_app/data/model/medicine.dart';

class MedicineListState {
  final List<Medicine> medicines;
  final bool isSearching;
  final bool isListening;
  final bool isLoading;

  MedicineListState({
    this.medicines,
    this.isSearching,
    this.isListening,
    this.isLoading,
  });

  factory MedicineListState.initial() {
    return new MedicineListState(
      medicines: [],
      isSearching: false,
      isListening: false,
      isLoading: false,
    );
  }

  MedicineListState copyWith({
    List<Medicine> medicines,
    bool isSearching,
    bool isListening,
    bool isLoading,
  }) {
    return new MedicineListState(
      medicines: medicines ?? this.medicines,
      isSearching: isSearching ?? this.isSearching,
      isListening: isListening ?? this.isListening,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
