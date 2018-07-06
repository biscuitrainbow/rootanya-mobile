import 'package:medical_app/data/loading_status.dart';

class AddMedicineState {
  final LoadingStatus loadingState;

  AddMedicineState({this.loadingState});

  factory AddMedicineState.initial() {
    return new AddMedicineState(
      loadingState: LoadingStatus.initial,
    );
  }

  AddMedicineState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return new AddMedicineState(
      loadingState: loadingStatus ?? this.loadingState,
    );
  }
}
