import 'package:flutter/material.dart';
import 'package:medical_app/data/model/tutorial.dart';
import 'package:medical_app/ui/tutorial_detail/tutorial_detail_screen.dart';

class TutorialScreen extends StatefulWidget {
  static final String route = '/tutorial';

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  List<Tutorial> tutorials;

  void _showTutorial(Tutorial tutorial) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => TutorialDetailScreen(tutorial: tutorial)));
  }

  @override
  void initState() {
    super.initState();

    tutorials = Tutorial.generate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('วิธีใช้งาน')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  height: 60.0,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.wifi, color: Theme.of(context).accentColor),
                      SizedBox(width: 32.0),
                      Expanded(
                        child: Text(
                          'เพื่อประสบการณ์การใช้งานที่สมบูรณ์กรุณาเชื่อมต่ออินเตอร์เน็ตอยู่ตลอดขณะใช้งาน',
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  height: 60.0,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.accessible, color: Theme.of(context).accentColor),
                      SizedBox(width: 32.0),
                      Expanded(
                        child: Text(
                          'แอปพลิเคชันนี้รองรับการทำงานกับ Disability mode ในโทรศัพท์ของผู้ใช้',
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final tutorial = tutorials[index];

                return ListTile(
                  leading: Icon(tutorial.icon),
                  title: Text(tutorial.title),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showTutorial(tutorial),
                );
              },
              itemCount: tutorials.length,
            ),
          ),
        ],
      ),
    );
  }
}
