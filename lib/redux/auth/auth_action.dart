import 'dart:async';

import 'package:medical_app/data/model/user.dart';

class LoginAction {
  final String email;
  final String password;
  final Completer<Null> completer;

  LoginAction(this.email, this.password, this.completer);
}

class LoginByIdAction {
  final String id;

  LoginByIdAction(this.id);
}

class SuccessLoginAction {
  final User user;

  SuccessLoginAction(this.user);
}

class ErrorLoginAction {}

class UpdateUserAction {
  final User user;
  final Completer<Null> completer;

  UpdateUserAction(this.user, this.completer);
}

class FetchUserAction {}

class RegisterAction {
  final User user;
  final Completer<Null> completer;

  RegisterAction(this.user, this.completer);
}

class LogoutAction {
  final Completer<Null> completer;

  LogoutAction(this.completer);
}

class SuccessLogoutAction {}

class ClearUserAction {}
