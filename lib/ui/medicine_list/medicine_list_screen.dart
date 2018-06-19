import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/ui/medicine_detail/medicine_detail_screen.dart';
import 'package:speech_recognition/speech_recognition.dart';

class MedicineListScreen extends StatefulWidget {
  final List<Medicine> medicines;
  final bool isSearching;
  final bool isListening;
  final bool isLoading;
  final Function onSearchClick;
  final Function onVoiceClicked;
  final Function onDispose;
  final Function(String) onSearchQueryChanged;
  final TextEditingController queryController;

  const MedicineListScreen({
    Key key,
    this.medicines,
    this.isSearching,
    this.isListening,
    this.isLoading,
    this.onSearchClick,
    this.onVoiceClicked,
    this.onDispose,
    this.onSearchQueryChanged,
    this.queryController,
  }) : super(key: key);

  @override
  MedicineListScreenState createState() {
    return new MedicineListScreenState();
  }
}

class MedicineListScreenState extends State<MedicineListScreen> {
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';
  String _currentLocale = 'th_TH';

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose();
  }

  void start() => _speech
      .listen(locale: 'th_TH')
      .then((result) => print('_MyAppState.start => result $result'))
      .catchError((error) => print(error));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() =>
      _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) => setState(() => print(locale));

  void onRecognitionStarted() => print('started');

  void onRecognitionResult(String text) => setState(() => transcription = text);

  void onRecognitionComplete() => print("completed");

  void activateSpeechRecognizer() {
    print('_MyAppState.activateSpeechRecognizer... ');
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  Widget buildSearchField(BuildContext context) {
    return new TextField(
      controller: widget.queryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'ค้นหายา...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      onChanged: (String text) {
        widget.onSearchQueryChanged(text);
      },
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      widget.onSearchQueryChanged(barcode);
      widget.queryController.text = barcode;
      widget.onSearchClick();
    } catch (error) {
      widget.onSearchQueryChanged('8-851123-113199');
      widget.queryController.text = '8-851123-113199';
      widget.onSearchClick();

      print(error);
    }
  }

  List<ListTile> buildMedicineItem() {
    return widget.medicines
        .map(
          (m) => new ListTile(
                title: new Text(m.name),
                onTap: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new MedicineDetailScreen(medicine: m),
                      ),
                    ),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: widget.isSearching
            ? buildSearchField(context)
            : new Text('รายการยา'),
        actions: <Widget>[
          !widget.isSearching
              ? new IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () => widget.onSearchClick(),
                )
              : new Container(),
          !widget.isSearching
              ? new IconButton(
                  icon: new Icon(Icons.keyboard_voice),
                  onPressed: () => start(),
                )
              : new Container(),
          !widget.isSearching
              ? new IconButton(
                  icon: new Icon(FontAwesomeIcons.barcode),
                  onPressed: () => scan(),
                )
              : new Container(),
          widget.isSearching
              ? new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () => widget.onSearchClick(),
                )
              : new Container(),
        ],
      ),
      floatingActionButton: widget.isListening
          ? new FloatingActionButton(
              onPressed: null,
              child: new Icon(
                Icons.mic_off,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: widget.isLoading
          ? new Center(
              child: CircularProgressIndicator(),
            )
          : new ListView(
              children: buildMedicineItem(),
            ),
    );
  }
}
