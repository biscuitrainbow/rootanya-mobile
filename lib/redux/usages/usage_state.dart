import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/contact.dart';
import 'package:rootanya/data/model/medicine.dart';
import 'package:rootanya/data/model/usage.dart';

class UsageState {
  final List<Medicine> usages;
  final LoadingStatus loadingStatus;

  UsageState({
    this.usages,
    this.loadingStatus,
  });

  factory UsageState.initial() {
    return UsageState(
      usages: [],
      loadingStatus: LoadingStatus.loading,
    );
  }

  UsageState copyWith({
    List<Medicine> usages,
    LoadingStatus loadingStatus,
  }) {
    return UsageState(
      usages: usages ?? this.usages,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
