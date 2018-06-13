import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/ui/barcode_scanner/barcode_scanner.dart';
import 'package:medical_app/ui/map_view/MapViewScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('เมนูหลัก'),
      ),
      body: new GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        children: <Widget>[
          new MenuItem(
            title: 'ค้นหาข้อมูลยา',
            iconData: FontAwesomeIcons.prescriptionBottle,
            onPress: () => print("press"),
          ),
          new MenuItem(
            title: 'สแกนบาร์โค้ด',
            iconData: FontAwesomeIcons.barcode,
            onPress: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new BarcodeScannerScreen())),
          ),
          new MenuItem(
            title: 'เตือนการกินยา',
            iconData: Icons.alarm_add,
            onPress: () => print("press"),
          ),
          new MenuItem(
            title: 'ร้านขายยาใกล้เคียง',
            iconData: FontAwesomeIcons.shoppingCart,
            onPress: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new MapViewScreen())),
          ),
          new MenuItem(
            title: 'ขอความช่วยเหลือ',
            iconData: Icons.call,
            onPress: () async => await launch('tel://0920922721'),
          ),
          new MenuItem(
            title: 'สรุปผลการใช้ยา',
            iconData: FontAwesomeIcons.book,
            onPress: () => print("press"),
          ),
          new MenuItem(
            title: 'เพิ่มข้อมูยา',
            iconData: FontAwesomeIcons.plus,
            onPress: () => print("press"),
          ),
          new MenuItem(
            title: 'ข้อมูลส่วนตัว',
            iconData: FontAwesomeIcons.peopleCarry,
            onPress: () => print("ข้อมูลส่วนตัว"),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPress;
  const MenuItem({Key key, this.title, this.iconData, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(
              iconData,
              size: 32.0,
            ),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(title),
            )
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
