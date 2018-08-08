import 'package:medical_app/data/network/history_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/usages/usage_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUsageMiddleware(
  HistoryRepository historyRepository,
) {
  return [
    new TypedMiddleware<AppState, AddUsageAction>(_addUsage(historyRepository)),
    new TypedMiddleware<AppState, FetchUsagesAction>(_fetchUsages(historyRepository)),
    new TypedMiddleware<AppState, EditUsageAction>(_updateUsage(historyRepository)),
    new TypedMiddleware<AppState, DeleteUsageAction>(_deleteUsage(historyRepository)),
  ];
}

Middleware<AppState> _addUsage(
  HistoryRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddUsageAction) {
      try {
        var user = store.state.user;

        await userRepository.addUsage(user.id, action.medicine.id, action.medicine.volume);
        action.completer.complete(null);
        store.dispatch(FetchUsagesAction());
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> _fetchUsages(
  HistoryRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchUsagesAction) {
      try {
        next(RequestUsagesAction());
        var user = store.state.user;
        var usages = await userRepository.fetchUsages(user.id);
        next(ReceiveUsagesAction(usages));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> _updateUsage(
  HistoryRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is EditUsageAction) {
      try {
        await userRepository.updateUsage(action.medicine);
        action.completer.complete(null);
        store.dispatch(FetchUsagesAction());
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> _deleteUsage(
  HistoryRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is DeleteUsageAction) {
      try {
        await userRepository.deleteUsage(action.usageId);
        action.completer.complete(null);
        store.dispatch(FetchUsagesAction());
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
