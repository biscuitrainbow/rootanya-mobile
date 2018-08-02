import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:medical_app/redux/contract/contact_state.dart';
import 'package:redux/redux.dart';

final contractsReducers = combineReducers<ContactsState>([
  new TypedReducer<ContactsState, FetchContactsRequested>(_fetchContactRequested),
  new TypedReducer<ContactsState, FetchContactSuccess>(_fetchContactSuccess),
  new TypedReducer<ContactsState, FetchContactError>(_fetchContactError),
]);

ContactsState _fetchContactRequested(
  ContactsState state,
  FetchContactsRequested action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

ContactsState _fetchContactSuccess(
  ContactsState state,
  FetchContactSuccess action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    contracts: action.contracts,
  );
}

ContactsState _fetchContactError(
  ContactsState state,
  FetchContactError action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
