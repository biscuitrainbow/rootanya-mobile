import 'package:flutter/material.dart';
import 'package:medical_app/data/model/medicine.dart';

class NotificationListScreen extends StatelessWidget {
  final List<Medicine> notifications;

  const NotificationListScreen({Key key, this.notifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('การแจ้งเตือน'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        children: buildNotificationGroupItem(context),
      ),
    );
  }

  List<Container> buildNotificationGroupItem(BuildContext context) =>
      notifications
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
                                          '${n.time.hour}:${n.time.minute}',
                                          style: new TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.w300,
                                            color: Theme.of(context).accentColor,
                                          ),
                                        ),
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
}
