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
      body: ListView.builder(
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
    );
  }
}
