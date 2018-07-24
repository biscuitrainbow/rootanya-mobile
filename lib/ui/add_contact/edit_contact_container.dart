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

class EditContactContainer extends StatelessWidget {
  final Contact contact;

  const EditContactContainer({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchContactsAction()),
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewModel) {
        return AddContactScreen(
          addContactState: viewModel.addContactState,
          onSave: viewModel.onSave,
          onDelete: viewModel.onDelete,
          isEditing: true,
          contact: contact,
        );
      },
    );
  }
}

class ViewModel {
  final AddContactState addContactState;
  final Function(Contact, BuildContext) onSave;
  final Function(Contact, BuildContext) onDelete;

  ViewModel({
    this.addContactState,
    this.onSave,
    this.onDelete,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      addContactState: store.state.addContactState,
      onSave: (Contact contact, BuildContext context) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          Navigator.of(context).pop();
        });

        store.dispatch(EditContactAction(contact, completer));
      },
      onDelete: (Contact contact,BuildContext context) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          Navigator.of(context).pop();
        });

        store.dispatch(DeleteContactAction(contact, completer));
      }
    );
  }
}
