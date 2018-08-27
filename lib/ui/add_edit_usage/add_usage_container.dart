import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/usages/usage_action.dart';
import 'package:medical_app/ui/add_edit_usage/add_edit_usage_screen.dart';
import 'package:medical_app/util/widget_utils.dart';
import 'package:redux/redux.dart';

class AddUsageContainer extends StatelessWidget {
  final Medicine medicine;

  const AddUsageContainer({Key key, this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewModel) {
        return AddUsageScreen(
          medicine: medicine,
          onSave: viewModel.onSave,
          isEditing: false,
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
        Navigator.of(context).pop();

        showToast('เพิ่มบันทึกแล้ว');
        //  Navigator.pushNamed(context, '/usages');
      });

      store.dispatch(AddUsageAction(medicine, completer));
    });
  }
}
