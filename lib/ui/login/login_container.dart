import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rootanya/exception/http_exception.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/auth/auth_action.dart';
import 'package:rootanya/redux/login/login_state.dart';
import 'package:rootanya/ui/home/home.dart';
import 'package:rootanya/ui/login/login_screen.dart';
import 'package:rootanya/util/widget_utils.dart';
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
          showToast('เข้าสู่ระบบแล้ว');
          Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.route));
        });
        completer.future.catchError((error) {
          if (error is UnauthorizedException) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
          }
        });

        store.dispatch(LoginAction(email, password, completer));
      },
    );
  }
}
