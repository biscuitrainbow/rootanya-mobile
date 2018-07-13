import 'package:medical_app/data/loading_status.dart';

class AddContactState {
  final LoadingStatus loadingStatus;

  AddContactState({this.loadingStatus});

  factory AddContactState.initial() {
    return AddContactState(
      loadingStatus: LoadingStatus.initial,
    );
  }

  AddContactState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return AddContactState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
