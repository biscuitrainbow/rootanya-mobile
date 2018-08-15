import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/ui/main_screen/main_screen.dart';
import 'package:redux/redux.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      distinct: true,
      converter: MainScreenViewModel.fromStore,
      builder: (BuildContext context, MainScreenViewModel vm) {
        return MainScreen(
          viewModel: vm,
        );
      },
    );
  }
}

class MainScreenViewModel {
  final String token;

  MainScreenViewModel({
    this.token,
  });

  static MainScreenViewModel fromStore(Store<AppState> store) {
    return new MainScreenViewModel(
      token: store.state.token,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is MainScreenViewModel && runtimeType == other.runtimeType && token == other.token;

  @override
  int get hashCode => token.hashCode;
}
