import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AddNotificationScreen extends StatefulWidget {
  @override
  _AddNotificationScreenState createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
           var pickedTime = await showTimePicker(context: context, initialTime: new TimeOfDay.now());

//           FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//           var initializationSettingsAndroid =
//           new AndroidInitializationSettings('mipmap/ic_launcher');
//           var initializationSettingsIOS = new IOSInitializationSettings();
//           var initializationSettings = new InitializationSettings(
//               initializationSettingsAndroid, initializationSettingsIOS);
//           flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//           flutterLocalNotificationsPlugin.initialize(initializationSettings,
//               selectNotification: onSelectNotification);
//
//
//           var time = new Time(pickedTime.hour, pickedTime.minute, 0);
//           var androidPlatformChannelSpecifics =
//           new AndroidNotificationDetails('repeatDailyAtTime channel id',
//               'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
//           var iOSPlatformChannelSpecifics =
//           new IOSNotificationDetails();
//           var platformChannelSpecifics = new NotificationDetails(
//               androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//           await flutterLocalNotificationsPlugin.showDailyAtTime(
//               0,
//               'show daily title',
//               'Daily notification shown at ${'กินยา'} ${time.hour}:${time.minute}:${time.second}',
//               time,
//               platformChannelSpecifics);
        },
        child: new Icon(Icons.add),
      ),
      body: new Column(
        children: <Widget>[],
      ),
    );
  }
}
