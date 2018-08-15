import 'package:medical_app/data/loading_status.dart';

class ProfileScreenState {
  final LoadingStatus loadingStatus;

  ProfileScreenState({this.loadingStatus});

  factory ProfileScreenState.initial() {
    return ProfileScreenState(
      loadingStatus: LoadingStatus.initial,
    );
  }

  ProfileScreenState copyWith({
    LoadingStatus loadingStatus,
  }) {
    return ProfileScreenState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
