import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/usages/usage_action.dart';
import 'package:medical_app/redux/usages/usage_state.dart';
import 'package:medical_app/ui/usages/usage_screen.dart';
import 'package:medical_app/util/widget_utils.dart';
import 'package:redux/redux.dart';

class UsageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store store) => store.dispatch(FetchUsagesAction()),
      converter: UsageScreenViewModel.fromStore,
      builder: (BuildContext context, UsageScreenViewModel viewModel) {
        return UsageScreen(
          viewModel: viewModel,
        );
      },
    );
  }
}

class UsageScreenViewModel {
  final UsageState usageState;
  final VoidCallback onRefresh;
  final bool isAuthenticated;
  final Function(String usageId, BuildContext) onDelete;

  UsageScreenViewModel({
    this.onRefresh,
    this.usageState,
    this.isAuthenticated,
    this.onDelete,
  });

  static UsageScreenViewModel fromStore(Store<AppState> store) {
    return new UsageScreenViewModel(
      usageState: store.state.usageState,
      isAuthenticated: store.state.token != null,
      onRefresh: () => store.dispatch(FetchUsagesAction()),
      onDelete: (String usageId, BuildContext context) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          showToast('ลบบันทึกแล้ว');
        });

        store.dispatch(DeleteUsageAction(usageId, completer));
      },
    );
  }
}
