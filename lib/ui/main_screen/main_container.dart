import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rootanya/data/model/user.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/ui/main_screen/main_screen.dart';
import 'package:redux/redux.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
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
