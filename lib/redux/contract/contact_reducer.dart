import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/contract/contact_action.dart';
import 'package:rootanya/redux/contract/contact_state.dart';
import 'package:redux/redux.dart';

final contractsReducers = combineReducers<ContactScreenState>([
  new TypedReducer<ContactScreenState, FetchContactsRequested>(_fetchContactRequested),
  new TypedReducer<ContactScreenState, FetchContactSuccess>(_fetchContactSuccess),
  new TypedReducer<ContactScreenState, FetchContactError>(_fetchContactError),
]);

ContactScreenState _fetchContactRequested(
  ContactScreenState state,
  FetchContactsRequested action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

ContactScreenState _fetchContactSuccess(
  ContactScreenState state,
  FetchContactSuccess action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    contracts: action.contracts,
  );
}

ContactScreenState _fetchContactError(
  ContactScreenState state,
  FetchContactError action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
