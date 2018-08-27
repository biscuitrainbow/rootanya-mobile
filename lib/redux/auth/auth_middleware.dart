import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/data/prefs/prefs_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/auth/auth_action.dart';
import 'package:medical_app/redux/login/login_action.dart';
import 'package:medical_app/redux/notification_list/notification_list_action.dart';
import 'package:medical_app/redux/profile/profile_screen_action.dart';
import 'package:medical_app/redux/register/register_screen_action.dart';
import 'package:medical_app/redux/token/token_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return [
    new TypedMiddleware<AppState, RegisterAction>(
      _register(userRepository, sharedPrefRepository),
    ),
    new TypedMiddleware<AppState, LoginAction>(
      _login(userRepository, sharedPrefRepository),
    ),
    new TypedMiddleware<AppState, LogoutAction>(
      _logout(userRepository, sharedPrefRepository),
    ),
    new TypedMiddleware<AppState, UpdateUserAction>(
      _updateUser(userRepository),
    ),
    new TypedMiddleware<AppState, FetchUserAction>(
      _fetchUser(userRepository),
    ),
  ];
}

Middleware<AppState> _register(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is RegisterAction) {
      next(ShowRegisterLoading());

      try {
        await userRepository.register(action.user);
        action.completer.complete(null);
      } catch (error) {
        print(error);
        action.completer.completeError(error);
      }

      next(HideRegisterLoading());
      next(action);
    }
  };
}

Middleware<AppState> _login(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is LoginAction) {
      next(ShowLoginLoadingAction());

      try {
        final user = await userRepository.login(action.email, action.password);
        await sharedPrefRepository.saveToken(user.token);

        next(SuccessLoginAction(user));
        next(SaveToken(user.token));
        next(SetNotifications());

        action.completer.complete(null);
      } catch (error) {
        action.completer.completeError(error);
      }

      next(ErrorLoginAction());
      next(action);
    }
  };
}

Middleware<AppState> _logout(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is LogoutAction) {
      try {
        await sharedPrefRepository.deleteToken();
        next(ClearToken());
        next(CancelAllNotification());
        //  next(SuccessLogoutAction());
        action.completer.complete(null);
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> _updateUser(
  UserRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is UpdateUserAction) {
      next(ShowProfileLoading());

      try {
        final token = store.state.token;
        await userRepository.update(action.user, token);

        next(FetchUserAction());
        action.completer.complete(null);
      } catch (error) {
        print(error);
      }

      next(HideProfileLoading());
      next(action);
    }
  };
}

Middleware<AppState> _fetchUser(
  UserRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchUserAction) {
      next(ShowProfileLoading());

      try {
        final token = store.state.token;
        final user = await userRepository.fetchUser(token);

        next(SuccessLoginAction(user));
      } catch (error) {
        print(error);
      }

      next(HideProfileLoading());
      next(action);
    }
  };
}
