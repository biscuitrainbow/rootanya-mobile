import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rootanya/redux/app/app_action.dart';
import 'package:rootanya/redux/app/app_state.dart';
import 'package:rootanya/redux/store.dart';
import 'package:rootanya/ui/home/home.dart';
import 'package:rootanya/ui/login/login_container.dart';
import 'package:rootanya/ui/login/login_screen.dart';
import 'package:rootanya/ui/main_screen/main_container.dart';
import 'package:rootanya/ui/main_screen/main_screen.dart';
import 'package:rootanya/ui/profile/profile_container.dart';
import 'package:rootanya/ui/register/register_container.dart';
import 'package:rootanya/ui/splashscreen/splash_screen.dart';
import 'package:rootanya/ui/tutorial/tutorial_screen.dart';
import 'package:rootanya/ui/usages/usage_container.dart';
import 'package:redux/redux.dart';

void main() async {
  var store = await createStore();

  runApp(MyApp(store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp(this.store);

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    widget.store.dispatch(InitAppAction());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'รู้ทันยา',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          fontFamily: 'Kanit',
        ),
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          MainScreen.route: (context) => MainContainer(),
          LoginScreen.route: (context) => LoginContainer(),
          HomeScreen.route: (context) => HomeScreen(),
          TutorialScreen.route: (context) => TutorialScreen(),
          '/usages': (context) => UsageContainer(),
          '/profile': (context) => ProfileContainer(),
          '/register': (context) => RegisterContainer(),
        },
      ),
    );
  }
}
