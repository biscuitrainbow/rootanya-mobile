import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:medical_app/redux/contract/contact_state.dart';
import 'package:redux/redux.dart';

final contractsReducers = combineReducers<ContactsState>([
  new TypedReducer<ContactsState, RequestContactsAction>(requestContact),
  new TypedReducer<ContactsState, ReceiveContactsAction>(receivedContacts),
  new TypedReducer<ContactsState, ErrorContractsAction>(errorContacts),
]);

ContactsState requestContact(
  ContactsState state,
  RequestContactsAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

ContactsState receivedContacts(
  ContactsState state,
  ReceiveContactsAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    contracts: action.contracts,
  );
}

ContactsState errorContacts(
  ContactsState state,
  ErrorContractsAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
