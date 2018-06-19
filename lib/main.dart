import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medical_app/redux/app/app_state.dart';
import 'package:medical_app/redux/store.dart';
import 'package:medical_app/ui/home/home.dart';
import 'package:map_view/map_view.dart';
import 'package:redux/redux.dart';

void main() async {
  var apiKey = "AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w";
  MapView.setApiKey(apiKey);

  var store = await createStore();

  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: new ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
        ),
        home: new HomeScreen(),
      ),
    );
  }
}
