import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/contact.dart';

class ContactsState {
  final List<Contact> contacts;
  final LoadingStatus loadingStatus;

  ContactsState({
    this.contacts,
    this.loadingStatus,
  });

  factory ContactsState.initial() {
    return ContactsState(
      contacts: [],
      loadingStatus: LoadingStatus.loading,
    );
  }

  ContactsState copyWith({
    List<Contact> contracts,
    LoadingStatus loadingStatus,
  }) {
    return ContactsState(
      contacts: contracts ?? this.contacts,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
