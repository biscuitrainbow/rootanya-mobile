import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/login/login_state.dart';
import 'package:medical_app/ui/home/home.dart';
import 'package:medical_app/ui/login/login_container.dart';
import 'package:medical_app/ui/splashscreen/splash_screen.dart';
import 'package:redux/redux.dart';

class SplashScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        if (vm.loginState.slientLoadingStatus == LoadingStatus.loading) return SplashScreen();

        if (vm.user == null) return LoginContainer();

        return HomeScreen();
      },
    );
  }
}

class ViewModel {
  final User user;
  final LoginState loginState;

  ViewModel({
    this.user,
    this.loginState,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      user: store.state.user,
      loginState: store.state.loginState,
    );
  }
}
