import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/usages/usage_action.dart';
import 'package:medical_app/redux/usages/usage_state.dart';
import 'package:medical_app/ui/usages/usage_screen.dart';
import 'package:redux/redux.dart';

class UsageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchUsagesAction()),
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel viewModel) {
        return UsageScreen(
          usageState: viewModel.usageState,
          onRefresh: viewModel.onRefresh,
          onDelete: viewModel.onDelete,
        );
      },
    );
  }
}

class ViewModel {
  final UsageState usageState;
  final VoidCallback onRefresh;
  final Function(String usageId, BuildContext) onDelete;

  ViewModel({
    this.onRefresh,
    this.usageState,
    this.onDelete,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      usageState: store.state.usageState,
      onRefresh: () => store.dispatch(FetchUsagesAction()),
      onDelete: (String usageId, BuildContext context) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('ลบสำเร็จ'),
                duration: Duration(seconds: 5),
              ));
        });

        store.dispatch(DeleteUsageAction(usageId, completer));
      },
    );
  }
}
