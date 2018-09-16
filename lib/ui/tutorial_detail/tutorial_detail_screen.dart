import 'package:flutter/material.dart';
import 'package:medical_app/data/model/tutorial.dart';

class TutorialDetailScreen extends StatefulWidget {
  final Tutorial tutorial;

  const TutorialDetailScreen({
    @required this.tutorial,
  });

  @override
  _TutorialDetailScreenState createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('วิธีใช้งาน${widget.tutorial.title}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            widget.tutorial.content,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
