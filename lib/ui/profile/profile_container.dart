import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/auth/auth_action.dart';
import 'package:medical_app/ui/profile/profile_screen.dart';
import 'package:redux/redux.dart';

class ProfileContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: ViewModel.fromStore,
      builder: (BuildContext context, ViewModel vm) {
        return ProfileScreen(user: vm.user, onUpdate: vm.onUpdate, onLogout: vm.onLogout);
      },
    );
  }
}

class ViewModel {
  final User user;
  final Function(User, BuildContext) onUpdate;
  final Function(BuildContext context) onLogout;

  ViewModel({
    this.user,
    this.onUpdate,
    this.onLogout,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
        user: store.state.user,
        onUpdate: (User user, BuildContext context) {
          Completer<Null> completer = Completer();
          completer.future.then((_) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('อัพเดตสำเร็จ')));
          });

          store.dispatch(UpdateUserAction(user, completer));
        },
        onLogout: (BuildContext context) {
          store.dispatch(LogoutAction());
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        });
  }
}
