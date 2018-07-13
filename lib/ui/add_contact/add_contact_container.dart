import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/redux/add_contact/add_contact_action.dart';
import 'package:medical_app/redux/add_contact/add_contact_state.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:medical_app/ui/add_contact/add_contact_screen.dart';
import 'package:redux/redux.dart';

class AddContactContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchContactsAction('1')),
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewModel) {
        return AddContactScreen(
          addContactState: viewModel.addContactState,
          onSave: viewModel.onSave,
          isEditing: false,
        );
      },
    );
  }
}

class ViewModel {
  final AddContactState addContactState;
  final Function(Contact, BuildContext) onSave;

  ViewModel({
    this.addContactState,
    this.onSave,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      addContactState: store.state.addContactState,
      onSave: (Contact contact, BuildContext context) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          Navigator.of(context).pop();
        });

        store.dispatch(AddContactAction(contact, completer));
      },
    );
  }
}
