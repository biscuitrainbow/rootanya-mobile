import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/ui/add_edit_usage/add_usage_container.dart';
import 'package:medical_app/ui/add_notification/medicine_notification_list_container.dart';

class MedicineDetailScreen extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailScreen({Key key, this.medicine}) : super(key: key);

  Future _showAddHistory(BuildContext context) {
    return Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new AddUsageContainer(medicine: medicine),
      ),
    );
  }

  Future _showMedicineNotifications(BuildContext context) {
    return Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new MedicineNotificationListContainer(
              medicineId: medicine.id,
              isAddingNotification: false,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(medicine.name),
        actions: <Widget>[
//          new IconButton(
//            icon: new Icon(
//              Icons.note_add,
//              color: Colors.white,
//            ),
//            onPressed: () => _showAddHistory(context),
//          ),
//          new IconButton(
//            icon: new Icon(
//              Icons.add_alert,
//              color: Colors.white,
//            ),
//            onPressed: () => _showMedicineNotifications(context),
//          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'สรรพคุณ', detail: medicine.fors),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'วิธีใช้', detail: medicine.method),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'ตัวยาสำคัญ', detail: medicine.ingredient),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'กลุ่มยา', detail: medicine.category),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'รูปแบบยา', detail: medicine.type),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'ถ้าลืมใช้ควรทำอย่างไร', detail: medicine.forget),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'ข้อควรระวัง', detail: medicine.notice),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new MedicineDetailItem(title: 'การเก็บรักษา', detail: medicine.keeping),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicineDetailItem extends StatelessWidget {
  final String title;
  final String detail;

  const MedicineDetailItem({
    Key key,
    this.title,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: new Text(
            title,
            style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        new Text(
          detail.isNotEmpty ? detail : 'ไม่มีข้อมูล',
          style: new TextStyle(
            fontSize: 16.5,
          ),
        )
      ],
    );
  }
}
