import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rootanya/data/loading_status.dart';
import 'package:rootanya/data/model/medicine.dart';
import 'package:rootanya/data/model/notification.dart' as AppNotification;

class MedicineNotificationListScreen extends StatelessWidget {
  final Medicine medicine;
  final Function(Time, Medicine) onAddNotification;
  final LoadingStatus loadingStatus;
  final bool isAddingNotification;

  MedicineNotificationListScreen({
    this.medicine,
    this.onAddNotification,
    this.loadingStatus,
    this.isAddingNotification,
  });

  void _showTimePicker(BuildContext context) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );

    if (pickedTime != null) {
      var time = new Time(pickedTime.hour, pickedTime.minute, 0);
      onAddNotification(time, medicine);
    }
  }

  Widget _buildSuccessContent(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      margin: EdgeInsets.only(bottom: 12.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Column(
            children: medicine.notifications.map((n) => _buildNotificationItem(n, context)).toList(),
          )
        ],
      ),
    );
  }

  Padding _buildNotificationItem(
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

  Widget _buildLoadingContent() {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyContent() {
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

  Widget _buildErrorContent() {
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

    if (isAddingNotification) {
      _showTimePicker(context);
    }

    switch (loadingStatus) {
      case LoadingStatus.initial:
      case LoadingStatus.loading:
        content = _buildLoadingContent();
        break;
      case LoadingStatus.success:
        content = medicine.notifications.isNotEmpty ? _buildSuccessContent(context) : _buildEmptyContent();
        break;
      case LoadingStatus.error:
        content = _buildErrorContent();
        break;
    }

    print(loadingStatus);

    return Scaffold(
      appBar: new AppBar(
        title: new Text('รายการแจ้งเตือน'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          _showTimePicker(context);
        },
        child: new Icon(Icons.add),
      ),
      body: content,
    );
  }
}
