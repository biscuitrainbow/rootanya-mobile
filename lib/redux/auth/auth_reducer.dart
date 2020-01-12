import 'package:rootanya/data/model/user.dart';
import 'package:rootanya/redux/auth/auth_action.dart';
import 'package:redux/redux.dart';

final authReducers = combineReducers<User>([
  new TypedReducer<User, SuccessLoginAction>(_successLogin),
  new TypedReducer<User, SuccessLogoutAction>(_changeUserName),
]);

User _successLogin(User state, SuccessLoginAction action) {
  return action.user;
}

User _successLogout(User state, SuccessLogoutAction action) {
  return null;
}

User _changeUserName(User state, SuccessLogoutAction action) {
  return state.copyWith(name: 'Logout out');
}
