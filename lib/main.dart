import 'package:flutter/material.dart';
import 'package:medical_app/ui/home/home.dart';
import 'package:map_view/map_view.dart';

void main() {
  var apiKey = "AIzaSyAXJ48mFl-jDIRzRRsykbI0_TOJxrXIo8w";
  MapView.setApiKey(apiKey);

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new HomeScreen();
  }
}
