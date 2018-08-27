import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/ui/main_screen/main_screen.dart';
import 'package:redux/redux.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onWillChange: (viewModel) => print(viewModel),
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
  final User user;

  MainScreenViewModel({
    this.token,
    this.user,
  });

  static MainScreenViewModel fromStore(Store<AppState> store) {
    return MainScreenViewModel(
      token: store.state.token,
      user: store.state.user,
    );
  }

  @override
  String toString() {
    return 'MainScreenViewModel{token: $token, user: $user}';
  }


}
