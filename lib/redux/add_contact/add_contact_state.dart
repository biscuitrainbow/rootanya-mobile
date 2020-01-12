import 'package:rootanya/data/loading_status.dart';

class AddContactScreenState {
  final LoadingStatus loadingStatus;

  AddContactScreenState({this.loadingStatus});

  factory AddContactScreenState.initial() {
    return AddContactScreenState(
      loadingStatus: LoadingStatus.initial,
    );
  }

  AddContactScreenState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return AddContactScreenState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
