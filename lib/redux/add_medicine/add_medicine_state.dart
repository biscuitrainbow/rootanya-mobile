import 'package:rootanya/data/loading_status.dart';

class AddMedicineScreenState {
  final LoadingStatus loadingState;

  AddMedicineScreenState({this.loadingState});

  factory AddMedicineScreenState.initial() {
    return new AddMedicineScreenState(
      loadingState: LoadingStatus.initial,
    );
  }

  AddMedicineScreenState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return new AddMedicineScreenState(
      loadingState: loadingStatus ?? this.loadingState,
    );
  }
}
