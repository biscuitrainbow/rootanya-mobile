import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rootanya/data/model/contact.dart';
import 'package:rootanya/redux/add_contact/add_contact_state.dart';
import 'package:rootanya/redux/add_contact/contact_action.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/contract/contact_action.dart';
import 'package:rootanya/ui/add_contact/add_contact_screen.dart';
import 'package:rootanya/util/widget_utils.dart';
import 'package:redux/redux.dart';

class EditContactContainer extends StatelessWidget {
  final Contact contact;

  EditContactContainer({
    this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchContacts()),
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
  final AddContactScreenState addContactState;
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
            showToast('บันทึกผู้ติดต่อแล้ว');
          });

          store.dispatch(EditContactAction(contact, completer));
        },
        onDelete: (Contact contact, BuildContext context) {
          Completer<Null> completer = Completer();
          completer.future.then((_) {
            Navigator.of(context).pop();
            showToast('ลบผู้ติดต่อแล้ว');
          });

          store.dispatch(DeleteContactAction(contact, completer));
        });
  }
}
