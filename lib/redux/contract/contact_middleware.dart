import 'package:rootanya/data/network/contact_repository.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/contract/contact_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createContactsMiddleware(
  ContractRepository contractRepository,
) {
  return [
    new TypedMiddleware<AppState, FetchContacts>(
      _fetchContacts(contractRepository),
    ),
  ];
}

Middleware<AppState> _fetchContacts(
  ContractRepository contractRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchContacts) {
      next(FetchContactsRequested());

      try {
        final token = store.state.token;
        final contacts = await contractRepository.fetchContact(token);
        next(FetchContactSuccess(contacts));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
