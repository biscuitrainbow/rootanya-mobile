import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/store.dart';
import 'package:medical_app/ui/home/home.dart';
import 'package:medical_app/ui/login/login_container.dart';
import 'package:medical_app/ui/login/login_screen.dart';
import 'package:medical_app/ui/main_screen/main_container.dart';
import 'package:medical_app/ui/main_screen/main_screen.dart';
import 'package:medical_app/ui/profile/profile_container.dart';
import 'package:medical_app/ui/register/register_container.dart';
import 'package:medical_app/ui/splashscreen/splash_screen.dart';
import 'package:medical_app/ui/usages/usage_container.dart';
import 'package:redux/redux.dart';

void main() async {
  var store = await createStore();

  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    store.dispatch(InitAppAction());

    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'For Blind Find Med',
        theme: new ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: 'Kanit',
        ),
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          MainScreen.route: (context) => MainContainer(),
          LoginScreen.route: (context) => LoginContainer(),
          HomeScreen.route: (context) => HomeScreen(),
          '/usages': (context) => UsageContainer(),
          '/profile': (context) => ProfileContainer(),
          '/register': (context) => RegisterContainer(),
        },
      ),
    );
  }
}
