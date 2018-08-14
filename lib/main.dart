import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_action.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/medicine_list/medicine_list_action.dart';
import 'package:medical_app/redux/store.dart';
import 'package:medical_app/ui/home/home.dart';
//import 'package:map_view/map_view.dart';
import 'package:medical_app/ui/login/login_container.dart';
import 'package:medical_app/ui/login/login_screen.dart';
import 'package:medical_app/ui/profile/profile_container.dart';
import 'package:medical_app/ui/register/register_container.dart';
import 'package:medical_app/ui/splashscreen/splash_container.dart';
import 'package:medical_app/ui/splashscreen/splash_screen.dart';
import 'package:medical_app/ui/usages/usage_container.dart';
import 'package:redux/redux.dart';

void main() async {
  var apiKey = "AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w";
//  MapView.setApiKey(apiKey);

  var store = await createStore();

  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp(this.store);

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
//        home: new SplashScreen(
//          duration: new Duration(seconds: 3),
//        ),
        home: SplashScreenContainer(),
        routes: {
          '/login': (context) => LoginContainer(),
          '/home': (context) => HomeScreen(),
          '/usages': (context) => UsageContainer(),
          '/profile': (context) => ProfileContainer(),
          '/register': (context) => RegisterContainer(),
        },
      ),
    );
  }
}
