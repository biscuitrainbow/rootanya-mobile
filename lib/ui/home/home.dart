import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/ui/contact/contact_list_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_mode.dart';
import 'package:medical_app/ui/nearby_pharmacies/nearby_pharmacies_container.dart';
import 'package:medical_app/ui/notification_list/notification_list_container.dart';
import 'package:medical_app/ui/tutorial/tutorial_screen.dart';
import 'package:medical_app/ui/usages/usage_container.dart';

class HomeScreen extends StatelessWidget {
  static final String route = '/home';

  void _showTutorial(BuildContext context) {
    Navigator.of(context).pushNamed(TutorialScreen.route);
  }

  Widget _buildHeader() {
    final logo = Image.asset(
      'assets/icons/med_icon_only.png',
      width: 100.0,
    );

    final title = Text(
      'รู้ทันยาเพื่อผู้พิการทางสายตา\nและผู้สูงอายุ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
      textAlign: TextAlign.center,
    );

    return Column(
      children: <Widget>[
        logo,
        title,
      ],
    );
  }

  Widget _buildMenus(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.4,
      children: <Widget>[
        MenuItem(
          title: 'ค้นหาข้อมูลยา',
          iconData: FontAwesomeIcons.pills,
          onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MedicineListContainer(mode: MedicineListMode.browsing),
                ),
              ),
        ),
        MenuItem(
          title: 'เตือนการกินยา',
          iconData: Icons.notifications,
          onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NotificationListContainer(),
                ),
              ),
        ),
        MenuItem(
          title: 'ร้านขายยาใกล้เคียง',
          iconData: FontAwesomeIcons.mapMarkerAlt,
          onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NearbyPharmaciesContainer(),
                ),
              ),
        ),
        MenuItem(
          title: 'ขอความช่วยเหลือ',
          iconData: Icons.call,
          onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ContactContainer(),
                ),
              ),
        ),
        MenuItem(
          title: 'บันทึกการใช้ยา',
          iconData: FontAwesomeIcons.book,
          enabled: true,
          onPress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => UsageContainer(),
                ),
              ),
        ),
        MenuItem(
          title: 'ข้อมูลส่วนตัว',
          iconData: Icons.person,
          onPress: () => Navigator.of(context).pushNamed('/profile'),
          enabled: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เมนูหลัก'),
        actions: <Widget>[
          Center(
            child: GestureDetector(
              onTap: () => _showTutorial(context),
              child: Text('วิธีใช้งาน'),
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildMenus(context),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onPress;
  final bool enabled;

  MenuItem({
    this.title,
    this.iconData,
    this.onPress,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 32.0,
              color: enabled ? Colors.white : Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(title),
            )
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
