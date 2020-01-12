import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rootanya/data/model/medicine.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/usages/usage_action.dart';
import 'package:rootanya/ui/add_edit_usage/add_edit_usage_screen.dart';
import 'package:redux/redux.dart';

class EditUsageContainer extends StatelessWidget {
  final Medicine usage;

  const EditUsageContainer({Key key, this.usage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewModel) {
        return AddUsageScreen(
          medicine: usage,
          onSave: viewModel.onSave,
          isEditing: true,
        );
      },
    );
  }
}

class ViewModel {
  final Function(Medicine, BuildContext) onSave;

  ViewModel({this.onSave});

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(onSave: (Medicine medicine, BuildContext context) {
      Completer<Null> completer = Completer();
      completer.future.then((_) {
        Navigator.of(context).pop();
      });

      store.dispatch(EditUsageAction(medicine, completer));
    });
  }
}
