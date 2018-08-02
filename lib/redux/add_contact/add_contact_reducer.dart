import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/add_contact/add_contact_state.dart';
import 'package:medical_app/redux/add_contact/contact_action.dart';
import 'package:redux/redux.dart';

final addContractsReducers = combineReducers<AddContactState>([
  new TypedReducer<AddContactState, SuccessAddContactAction>(successAddContacts),
  new TypedReducer<AddContactState, ErrorAddContactAction>(errorAddContacts),
  new TypedReducer<AddContactState, RequestAddContactAction>(requestAddContacts),
]);

AddContactState requestAddContacts(
  AddContactState state,
  RequestAddContactAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

AddContactState successAddContacts(
  AddContactState state,
  SuccessAddContactAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
  );
}

AddContactState errorAddContacts(
  AddContactState state,
  ErrorAddContactAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
