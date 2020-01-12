import 'package:rootanya/data/loading_status.dart';

class RegisterScreenState {
  final LoadingStatus loadingStatus;

  RegisterScreenState({this.loadingStatus});

  factory RegisterScreenState.initial() {
    return RegisterScreenState(
      loadingStatus: LoadingStatus.initial,
    );
  }

  RegisterScreenState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return RegisterScreenState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
