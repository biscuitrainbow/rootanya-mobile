import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/ui/add_medicine/add_medicine_container.dart';
import 'package:medical_app/ui/add_medicine/add_medicine_screen.dart';
import 'package:medical_app/ui/barcode_scanner/barcode_scanner.dart';
import 'package:medical_app/ui/contact/contact_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/nearby_pharmacies/nearby_pharmacies_container.dart';
import 'package:medical_app/ui/nearby_pharmacies/nearby_pharmacies_screen.dart';
import 'package:medical_app/ui/notification_list/notification_list_container.dart';
import 'package:medical_app/ui/usages/usage_container.dart';
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
            onPress: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new MedicineListContainer(),
                  ),
                ),
          ),
          new MenuItem(
            title: 'เตือนการกินยา',
            iconData: Icons.alarm_add,
            onPress: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new NotificationListContainer(),
                  ),
                ),
          ),
          new MenuItem(
            title: 'ร้านขายยาใกล้เคียง',
            iconData: FontAwesomeIcons.shoppingCart,
            onPress: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new NearbyPharmaciesContainer(),
                  ),
                ),
          ),
          new MenuItem(
            title: 'ขอความช่วยเหลือ',
            iconData: Icons.call,
            onPress: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (BuildContext context) => ContactContainer(),
              ),
            ),
          ),
          new MenuItem(
            title: 'บันทึกการใช้ยา',
            iconData: FontAwesomeIcons.book,
            enabled: true,
            onPress: () => Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (BuildContext context) => UsageContainer(),
              ),
            ),
          ),
          new MenuItem(
            title: 'ข้อมูลส่วนตัว',
            iconData: Icons.person,
            onPress: () => Navigator.of(context).pushNamed('/profile'),
            enabled: true,
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
  final bool enabled;

  const MenuItem({
    Key key,
    this.title,
    this.iconData,
    this.onPress,
    this.enabled = true,
  }) : super(key: key);

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
              color: enabled? Colors.white : Colors.grey,
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
