import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/add_contact/add_contact_state.dart';
import 'package:rootanya/redux/add_contact/contact_action.dart';
import 'package:redux/redux.dart';

final addContractsReducers = combineReducers<AddContactScreenState>([
  new TypedReducer<AddContactScreenState, SuccessAddContactAction>(successAddContacts),
  new TypedReducer<AddContactScreenState, ErrorAddContactAction>(errorAddContacts),
  new TypedReducer<AddContactScreenState, RequestAddContactAction>(requestAddContacts),
]);

AddContactScreenState requestAddContacts(
  AddContactScreenState state,
  RequestAddContactAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

AddContactScreenState successAddContacts(
  AddContactScreenState state,
  SuccessAddContactAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
  );
}

AddContactScreenState errorAddContacts(
  AddContactScreenState state,
  ErrorAddContactAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
