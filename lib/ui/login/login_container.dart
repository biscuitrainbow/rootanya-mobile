import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/auth/auth_action.dart';
import 'package:medical_app/redux/login/login_state.dart';
import 'package:medical_app/ui/login/login_screen.dart';
import 'package:redux/redux.dart';

class LoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return LoginScreen(
          onLogin: vm.onLogin,
          loginState: vm.loginState,
        );
      },
    );
  }
}

class ViewModel {
  final Function(String, String, BuildContext) onLogin;
  final LoginState loginState;

  ViewModel({
    this.loginState,
    this.onLogin,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      loginState: store.state.loginState,
      onLogin: (String email, String password, BuildContext context) {
        Completer<Null> completer = Completer();
        completer.future.then((_) {
          Navigator.of(context).pushReplacementNamed('/home');
        });

        store.dispatch(LoginAction(email, password, completer));
      },
    );
  }
}
