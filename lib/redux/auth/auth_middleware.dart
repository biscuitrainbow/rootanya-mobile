import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/data/prefs/prefs_repository.dart';
import 'package:medical_app/redux/add_medicine/add_medicine_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/auth/auth_action.dart';
import 'package:medical_app/redux/login/login_action.dart';
import 'package:medical_app/redux/register/register_screen_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return [
    new TypedMiddleware<AppState, LoginAction>(
      _login(userRepository, sharedPrefRepository),
    ),
    new TypedMiddleware<AppState, LoginByIdAction>(
      _loginById(userRepository, sharedPrefRepository),
    ),
    new TypedMiddleware<AppState, UpdateUserAction>(
      _updateUser(userRepository),
    ),
    new TypedMiddleware<AppState, RegisterAction>(
      _register(userRepository, sharedPrefRepository),
    ),
    new TypedMiddleware<AppState, LogoutAction>(
      _logout(userRepository, sharedPrefRepository),
    )
  ];
}

Middleware<AppState> _logout(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is LogoutAction) {
      try {
        await sharedPrefRepository.deleteUser();
        next(SuccessLogoutAction());
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> _register(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is RegisterAction) {
      try {
        next(ShowRegisterLoading());
        await userRepository.register(action.user);
        action.completer.complete(null);
        next(HideRegisterLoading());
      } catch (error) {
        next(HideRegisterLoading());
      }
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
      try {
        next(ShowLoginLoadingAction());
        final user = await userRepository.login(action.email, action.password);
        await sharedPrefRepository.storeUser(user.id);
        next(SuccessLoginAction(user));
        action.completer.complete(null);
      } catch (error) {
        print(error);
        next(ErrorLoginAction());
      }
      next(action);
    }
  };
}

Middleware<AppState> _loginById(
  UserRepository userRepository,
  SharedPreferencesRepository sharedPrefRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is LoginByIdAction) {
      try {
        print('login by id');
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
  return (Store store, action, NextDispatcher next) async {
    if (action is UpdateUserAction) {
      try {
        var user = await userRepository.update(action.user);
        action.completer.complete(null);
        next(SuccessLoginAction(user));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
