import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/data/prefs/prefs_repository.dart';
import 'package:medical_app/redux/app/app_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/auth/auth_action.dart';
import 'package:medical_app/redux/login/login_action.dart';
import 'package:medical_app/redux/token/token_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAppMiddleware(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return [
    TypedMiddleware<AppState, InitAppAction>(
      _initApp(userRepository, sharedPrefRepository),
    ),
  ];
}

Middleware<AppState> _initApp(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is InitAppAction) {
      try {
        var token = await sharedPrefRepository.getToken();

        if (token != null) {
          next(SaveToken(token));

          var user = await userRepository.fetchUser(token);
          next(SuccessLoginAction(user));
        }
      } catch (error) {
        print(error);
      }

      next(HideSilentLoadingAction());
      next(action);
    }
  };
}
