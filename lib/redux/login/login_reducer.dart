import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/auth/auth_action.dart';
import 'package:rootanya/redux/login/login_action.dart';
import 'package:rootanya/redux/login/login_state.dart';
import 'package:redux/redux.dart';

final loginReducers = combineReducers<LoginState>([
  new TypedReducer<LoginState, ShowLoginLoadingAction>(
    _showLoading,
  ),
  new TypedReducer<LoginState, SuccessLoginAction>(
    _successLogin,
  ),
  new TypedReducer<LoginState, ErrorLoginAction>(
    _errorLogin,
  ),
  new TypedReducer<LoginState, ShowSilentLoadingAction>(
    _showSilentLoading,
  ),
  new TypedReducer<LoginState, HideSilentLoadingAction>(
    _hideSilentLoading,
  ),
]);

LoginState _showLoading(
  LoginState state,
  ShowLoginLoadingAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

LoginState _successLogin(
  LoginState state,
  SuccessLoginAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.success);
}

LoginState _errorLogin(
  LoginState state,
  ErrorLoginAction action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}

LoginState _showSilentLoading(
  LoginState state,
  ShowSilentLoadingAction action,
) {
  return state.copyWith(slientLoadingStatus: LoadingStatus.loading);
}

LoginState _hideSilentLoading(
  LoginState state,
  HideSilentLoadingAction action,
) {
  return state.copyWith(slientLoadingStatus: LoadingStatus.initial);
}
