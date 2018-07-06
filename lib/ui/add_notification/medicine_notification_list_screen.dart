import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/model/notification.dart' as AppNotification;

class MedicineNotificationListScreen extends StatelessWidget {
  final Medicine medicine;
  final Function(Time, Medicine) onAddNotification;
  final LoadingStatus loadingStatus;

  const MedicineNotificationListScreen({
    Key key,
    this.medicine,
    this.onAddNotification,
    this.loadingStatus,
  }) : super(key: key);

  Widget buildSuccessContent(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      margin: EdgeInsets.only(bottom: 12.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            children: medicine.notifications.map((n) => buildNotificationItem(n, context)).toList(),
          )
        ],
      ),
    );
  }

  Widget buildLoadingContent() {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            FontAwesomeIcons.frown,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("คุณยังไม่มีการแจ้งเตือนสำหรับยานี้")
        ],
      ),
    );
  }

  Widget buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            FontAwesomeIcons.frown,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("มีความผิดพลาดเกิดขึ้น ลองอีกครั้ง")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var content;

    switch (loadingStatus) {
      case LoadingStatus.initial:
      case LoadingStatus.loading:
        content = buildLoadingContent();
        break;
      case LoadingStatus.success:
        content = medicine.notifications.isNotEmpty ? buildSuccessContent(context) : buildEmptyContent();
        break;
      case LoadingStatus.error:
        content = buildErrorContent();
        break;
    }

    print(loadingStatus);

    return Scaffold(
      appBar: new AppBar(
        title: new Text('รายการแจ้งเตือน'),
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
      body: content,
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
            '${_toTwoDigitString(n.time.hour)}:${_toTwoDigitString(n.time.minute)}',
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

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
}
