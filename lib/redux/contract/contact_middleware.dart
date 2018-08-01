import 'package:medical_app/data/network/contact_repository.dart';
import 'package:medical_app/data/network/google_map_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createContactsMiddleware(
  ContractRepository contractRepository,
) {
  return [
    new TypedMiddleware<AppState, FetchContactsAction>(
      fetchContacts(contractRepository),
    ),
  ];
}

Middleware<AppState> fetchContacts(
    ContractRepository contractRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchContactsAction) {
      try {
        next(RequestContactsAction());

        var user = store.state.user;
        var contacts = await contractRepository.fetchContact(user.id);
        next(ReceiveContactsAction(contacts));
      } catch (error) {}
      next(action);
    }
  };
}
