import 'package:medical_app/data/network/contact_repository.dart';
import 'package:medical_app/data/network/user_repository.dart';
import 'package:medical_app/redux/add_contact/contact_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAddContactMiddleware(
  ContractRepository contractRepository,
) {
  return [
    new TypedMiddleware<AppState, AddContactAction>(addContact(contractRepository)),
    new TypedMiddleware<AppState, EditContactAction>(editContact(contractRepository)),
    new TypedMiddleware<AppState, DeleteContactAction>(deleteContact(contractRepository)),
  ];
}

Middleware<AppState> addContact(
  ContractRepository contractRepository,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AddContactAction) {
      try {
        var user = store.state.user;

        next(RequestAddContactAction());

        await contractRepository.addContact(action.contact, user.id);
        action.completer.complete(null);

        next(SuccessAddContactAction());
        store.dispatch(FetchContactsAction());
      } catch (error) {
        next(ErrorAddContactAction());
        print(error);
      }

      next(action);
    }
  };
}

Middleware<AppState> editContact(
  ContractRepository contractRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is EditContactAction) {
      try {
        next(RequestEditContactAction());

        await contractRepository.updateContact(action.contact);
        action.completer.complete(null);

        next(SuccessEditContactAction());
        store.dispatch(FetchContactsAction());
      } catch (error) {
        next(ErrorEditContactAction());
      }

      next(action);
    }
  };
}

Middleware<AppState> deleteContact(
  ContractRepository contractRepository,
) {
  return (Store store, action, NextDispatcher next) async {
    if (action is DeleteContactAction) {
      print('delete');

      try {
        await contractRepository.deleteContact(action.contact.id);
        action.completer.complete(null);

        store.dispatch(FetchContactsAction());
      } catch (error) {}
      next(action);
    }
  };
}
