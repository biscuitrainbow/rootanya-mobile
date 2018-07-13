import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:uuid/uuid.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;

  NotificationService(this.localNotificationsPlugin);

  Future<int> addNotification(Time time, Medicine medicine) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.Max,
      priority: Priority.Max,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );

    var random = new Random();
    var id = random.nextInt(99999 - 0);

    await localNotificationsPlugin.showDailyAtTime(
      id,
      'แจ้งเตือนรับประทานยา',
      '${'รับประทานยา'} ${medicine.name}',
      time,
      platformChannelSpecifics,
    );

    return id;
  }
}
