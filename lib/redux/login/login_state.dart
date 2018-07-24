import 'package:medical_app/data/loading_status.dart';

class LoginState {
  final LoadingStatus loadingStatus;
  final LoadingStatus slientLoadingStatus;

  LoginState({
    this.loadingStatus,
    this.slientLoadingStatus,
  });

  factory LoginState.initial() {
    return LoginState(
      loadingStatus: LoadingStatus.initial,
      slientLoadingStatus: LoadingStatus.initial,
    );
  }

  LoginState copyWith({
    LoadingStatus loadingStatus,
    LoadingStatus slientLoadingStatus,
  }) {
    return LoginState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      slientLoadingStatus: slientLoadingStatus ?? this.slientLoadingStatus,
    );
  }
}
