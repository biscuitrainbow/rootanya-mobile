import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/notification.dart' as AppNotification;

class MedicineNotificationListScreen extends StatelessWidget {
  final Medicine medicine;
  final Function(Time, Medicine) onAddNotification;

  const MedicineNotificationListScreen({
    Key key,
    this.medicine,
    this.onAddNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(medicine.name),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          var pickedTime = await showTimePicker(
            context: context,
            initialTime: new TimeOfDay.now(),
          );

          if (pickedTime != null) {
            var time = new Time(pickedTime.hour, pickedTime.minute, 0);
            onAddNotification(time, medicine);
          }
        },
        child: new Icon(Icons.add),
      ),
      body: Container(
        padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        margin: EdgeInsets.only(bottom: 12.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Column(
              children: medicine.notifications
                  .map((n) => buildNotificationItem(n, context))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationItem(
    AppNotification.Notification n,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            '${n.time.hour}:${n.time.minute}',
            style: new TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
