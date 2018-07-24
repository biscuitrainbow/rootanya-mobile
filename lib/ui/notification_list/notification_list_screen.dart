import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_screen.dart';

class NotificationListScreen extends StatelessWidget {
  final List<Medicine> notifications;
  final LoadingStatus loadingStatus;
  final Function(String) onDelete;

  const NotificationListScreen({
    Key key,
    this.notifications,
    this.loadingStatus,
    this.onDelete,
  }) : super(key: key);

  Widget buildLoadingContent() {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSuccessContent(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      children: buildNotificationGroupItem(context),
    );
  }

  Widget buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.alarm,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("ยังไม่มีการแจ้งเตือน")
        ],
      ),
    );
  }

  Widget buildErrorContent() {
    return Center(
      child: Column(
        children: <Widget>[
          new Icon(
            Icons.alarm,
          ),
          new Text("มีความผิดพลาดเกิดขึ้น ลองอีกครั้ง")
        ],
      ),
    );
  }

  void openMedicineListPage(BuildContext context) {
    Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (_) => MedicineListContainer(),
          ),
        );
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  List<Container> buildNotificationGroupItem(BuildContext context) => notifications
      ?.map(
        (m) => Container(
              margin: EdgeInsets.only(bottom: 12.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    m.name,
                    style: new TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                  new Column(
                    children: m.notifications
                        .map(
                          (n) => Padding(
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
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        onDelete(n.uuid);
                                      },
                                    )
                                  ],
                                ),
                              ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
      )
      ?.toList();

  @override
  Widget build(BuildContext context) {
    var content;

    switch (loadingStatus) {
      case LoadingStatus.initial:
      case LoadingStatus.loading:
        content = buildLoadingContent();
        break;
      case LoadingStatus.success:
        content = notifications.isNotEmpty ? buildSuccessContent(context) : buildEmptyContent();
        break;
      case LoadingStatus.error:
        content = buildErrorContent();
        break;
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text('การแจ้งเตือน'),
      ),
      body: content,
      floatingActionButton: new FloatingActionButton(
        onPressed: () => openMedicineListPage(context),
        child: new Icon(Icons.alarm_add),
      ),
    );
  }
}
