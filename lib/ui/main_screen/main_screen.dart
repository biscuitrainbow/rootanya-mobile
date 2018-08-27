import 'package:flutter/material.dart';
import 'package:medical_app/ui/home/home.dart';
import 'package:medical_app/ui/login/login_container.dart';
import 'package:medical_app/ui/main_screen/main_container.dart';

class MainScreen extends StatefulWidget {
  static final String route = '/main';

  final MainScreenViewModel viewModel;

  MainScreen({
    this.viewModel,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.viewModel.token == null ? LoginContainer() : HomeScreen();
  }
}
