import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_app/data/model/medicine.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;

  NotificationService(this.localNotificationsPlugin);

  Future<Null> setNotification(List<Medicine> medicines) async {
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

    medicines.forEach((medicine) {
      medicine.notifications.forEach((notification) async {
        await localNotificationsPlugin.showDailyAtTime(
          notification.uuid,
          'แจ้งเตือนการใช้ยา',
          '${'ใช้ยา'} ${medicine.name}',
          notification.time,
          platformChannelSpecifics,
        );
      });
    });
  }

  Future<int> createNotification(Time time, Medicine medicine) async {
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

    var random = Random();
    var max = 99999;
    var min = 10000;

    var id = max - random.nextInt(max - min);

    await localNotificationsPlugin.showDailyAtTime(
      id,
      'แจ้งเตือนการใช้ยา',
      '${'ใช้ยา'} ${medicine.name}',
      time,
      platformChannelSpecifics,
    );

    return id;
  }

  Future<Null> cancelNotification(int id) async {
    await localNotificationsPlugin.cancel(id);
  }

  Future<Null> cancelAllNotification() async {
    await localNotificationsPlugin.cancelAll();
  }
}
