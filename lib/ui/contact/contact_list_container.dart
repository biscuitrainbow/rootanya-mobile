import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/redux/add_contact/contact_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:medical_app/redux/contract/contact_state.dart';
import 'package:medical_app/ui/contact/contact__list_screen.dart';
import 'package:redux/redux.dart';

class ContactContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchContacts()),
      converter: ContactListViewModel.fromStore,
      builder: (BuildContext context, ContactListViewModel viewModel) {
        return ContactListScreen(
          viewModel : viewModel,
        );
      },
    );
  }
}

class ContactListViewModel {
  final ContactsState contactsState;
  final VoidCallback onRefresh;
  final Function(Contact, BuildContext) onDelete;

  ContactListViewModel({
    this.onRefresh,
    this.contactsState,
    this.onDelete,
  });

  static ContactListViewModel fromStore(Store<AppState> store) {
    return new ContactListViewModel(
        contactsState: store.state.contactState,
        onRefresh: () => store.dispatch(FetchContacts()),
        onDelete: (Contact contact, BuildContext context) {
          Completer<Null> completer = Completer();
          completer.future.then((_) {
            //Navigator.of(context).pop();
          });

          store.dispatch(DeleteContactAction(contact, completer));
        });
  }
}
