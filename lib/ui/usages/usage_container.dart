import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/contract/contact_action.dart';
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
        );
      },
    );
  }
}

class ViewModel {
  final UsageState usageState;
  final VoidCallback onRefresh;

  ViewModel({
    this.onRefresh,
    this.usageState,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      usageState: store.state.usageState,
      onRefresh: () => store.dispatch(FetchUsagesAction()),
    );
  }
}
