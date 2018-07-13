import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/usages/usage_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUsageMiddleware(
  UserRepository userRepository,
) {
  return [
    new TypedMiddleware<AppState, FetchUsagesAction>(fetchUsages(userRepository)),
    new TypedMiddleware<AppState, AddUsageAction>(addUsage(userRepository)),

  ];
}

Middleware<AppState> addUsage(
  UserRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is AddUsageAction) {
      try {
         await userRepository.addUsage('1', action.medicine.id, action.volume);
         action.completer.complete(null);
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> fetchUsages(
  UserRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchUsagesAction) {
      try {
        next(RequestUsagesAction());
        var usages = await userRepository.fetchUsages('1');
        next(ReceiveUsagesAction(usages));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
