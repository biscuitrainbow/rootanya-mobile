import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
import 'package:medical_app/redux/contract/contact_state.dart';
import 'package:medical_app/ui/contact/contact_screen.dart';
import 'package:redux/redux.dart';

class ContactContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchContactsAction('1')),
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewModel) {

        return ContactScreen(
          contactState: viewModel.contactsState,
          onRefresh: viewModel.onRefresh,
        );
      },
    );
  }
}

class ViewModel {
  final ContactsState contactsState;
  final VoidCallback onRefresh;

  ViewModel({
    this.onRefresh,
    this.contactsState,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      contactsState: store.state.contactState,
      onRefresh: () => store.dispatch(FetchContactsAction('1')),
    );
  }
}
