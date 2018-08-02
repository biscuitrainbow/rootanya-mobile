import 'package:medical_app/data/network/contact_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
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
      var user = store.state.user;

      try {
        next(FetchContactsRequested());
        var contacts = await contractRepository.fetchContact(user.id);
        next(FetchContactSuccess(contacts));
      } catch (error) {
        print(error);
      }
      next(action);
    }
  };
}
