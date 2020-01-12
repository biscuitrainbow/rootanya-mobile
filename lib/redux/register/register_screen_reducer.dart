import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/register/register_screen_action.dart';
import 'package:rootanya/redux/register/register_screen_state.dart';
import 'package:redux/redux.dart';

final registerReducers = combineReducers<RegisterScreenState>([
  new TypedReducer<RegisterScreenState, ShowRegisterLoading>(
    _showRegisterLoading,
  ),
  new TypedReducer<RegisterScreenState, HideRegisterLoading>(
    _hideLoadingStatus,
  )
]);

RegisterScreenState _showRegisterLoading(
  RegisterScreenState state,
  ShowRegisterLoading action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

RegisterScreenState _hideLoadingStatus(
  RegisterScreenState state,
  HideRegisterLoading action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.initial);
}
