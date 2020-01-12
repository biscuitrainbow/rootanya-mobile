import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/redux/profile/profile_screen_action.dart';
import 'package:rootanya/redux/profile/profile_screen_state.dart';
import 'package:redux/redux.dart';

final profileReducers = combineReducers<ProfileScreenState>([
  new TypedReducer<ProfileScreenState, ShowProfileLoading>(
    _showRegisterLoading,
  ),
  new TypedReducer<ProfileScreenState, HideProfileLoading>(
    _hideLoadingStatus,
  )
]);

ProfileScreenState _showRegisterLoading(
  ProfileScreenState state,
  ShowProfileLoading action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

ProfileScreenState _hideLoadingStatus(
  ProfileScreenState state,
  HideProfileLoading action,
) {
  return state.copyWith(loadingStatus: LoadingStatus.initial);
}
