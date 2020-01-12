import 'package:rootanya/data/network/history_repository.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/usages/usage_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createUsageMiddleware(
  UsageRepository historyRepository,
) {
  return [
    new TypedMiddleware<AppState, AddUsageAction>(_addUsage(historyRepository)),
    new TypedMiddleware<AppState, FetchUsagesAction>(_fetchUsages(historyRepository)),
    new TypedMiddleware<AppState, EditUsageAction>(_updateUsage(historyRepository)),
    new TypedMiddleware<AppState, DeleteUsageAction>(_deleteUsage(historyRepository)),
  ];
}

Middleware<AppState> _addUsage(
  UsageRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddUsageAction) {
      try {
        final token = store.state.token;
        await userRepository.addUsage(token, action.medicine.id, action.medicine.volume);
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
  UsageRepository userRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchUsagesAction) {
      next(RequestUsagesAction());

      try {
        final token = store.state.token;
        var usages = await userRepository.fetchUsages(token);

        next(ReceiveUsagesAction(usages));
      } catch (error) {
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> _updateUsage(
  UsageRepository usageRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is EditUsageAction) {
      try {
        final token = store.state.token;
        await usageRepository.updateUsage(token, action.medicine);

        store.dispatch(FetchUsagesAction());
        action.completer.complete(null);
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}

Middleware<AppState> _deleteUsage(
  UsageRepository userRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is DeleteUsageAction) {
      try {
        final token = store.state.token;
        await userRepository.deleteUsage(token, action.usageId);

        store.dispatch(FetchUsagesAction());
        action.completer.complete(null);
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
