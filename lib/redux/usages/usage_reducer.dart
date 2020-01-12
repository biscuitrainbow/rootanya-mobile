import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/contract/contact_action.dart';
import 'package:rootanya/redux/usages/usage_action.dart';
import 'package:rootanya/redux/usages/usage_state.dart';
import 'package:redux/redux.dart';

final usagesReducers = combineReducers<UsageState>([
  new TypedReducer<UsageState, RequestUsagesAction>(requestUsages),
  new TypedReducer<UsageState, ReceiveUsagesAction>(receivedUsages),
  new TypedReducer<UsageState, ErrorUsagesAction>(errorUsages),
]);

UsageState requestUsages(
  UsageState state,
  RequestUsagesAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.loading,
  );
}

UsageState receivedUsages(
  UsageState state,
  ReceiveUsagesAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    usages: action.usages,
  );
}

UsageState errorUsages(
  UsageState state,
  ErrorUsagesAction action,
) {
  return state.copyWith(
    loadingStatus: LoadingStatus.error,
  );
}
