import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/contact.dart';

class ContactScreenState {
  final List<Contact> contacts;
  final LoadingStatus loadingStatus;

  ContactScreenState({
    this.contacts,
    this.loadingStatus,
  });

  factory ContactScreenState.initial() {
    return ContactScreenState(
      contacts: [],
      loadingStatus: LoadingStatus.loading,
    );
  }

  ContactScreenState copyWith({
    List<Contact> contracts,
    LoadingStatus loadingStatus,
  }) {
    return ContactScreenState(
      contacts: contracts ?? this.contacts,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
