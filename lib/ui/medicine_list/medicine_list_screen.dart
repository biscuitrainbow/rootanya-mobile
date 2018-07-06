import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/ui/medicine_detail/medicine_detail_screen.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:simple_permissions/simple_permissions.dart';

class MedicineListScreen extends StatefulWidget {
  final List<Medicine> medicines;
  final bool isSearching;
  final bool isListening;
  final bool isLoading;
  final LoadingStatus loadingStatus;
  final Function onSearchClick;
  final Function onVoiceClicked;
  final Function onDispose;
  final Function(String) onSearchQueryChanged;
  final TextEditingController queryController;

  final VoidCallback showListening;
  final VoidCallback hideListening;

  const MedicineListScreen({
    Key key,
    this.medicines,
    this.isSearching,
    this.isListening,
    this.isLoading,
    this.loadingStatus,
    this.onSearchClick,
    this.onVoiceClicked,
    this.onDispose,
    this.onSearchQueryChanged,
    this.queryController,
    this.showListening,
    this.hideListening,
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

  @override
  Widget build(BuildContext context) {
    var content;

    switch (widget.loadingStatus) {
      case LoadingStatus.initial:
        content = buildInitialContent();
        break;
      case LoadingStatus.loading:
        content = buildLoadingContent();
        break;
      case LoadingStatus.success:
        content = widget.medicines.isNotEmpty ? buildSuccessContent() : buildEmptyContent();
        break;
      case LoadingStatus.error:
        content = buildErrorContent();
        break;
    }

    return Scaffold(
      appBar: new AppBar(
        title: widget.isSearching ? buildSearchField(context) : new Text('รายการยา'),
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
              onPressed: () {
                widget.hideListening();
                _speech.cancel();
              },
              child: new Icon(
                Icons.mic_off,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: content,
    );
  }

  void start() async {
    if (!await SimplePermissions.checkPermission(Permission.RecordAudio)) {
      SimplePermissions.requestPermission(Permission.RecordAudio);
    }

  //  print(await SimplePermissions.checkPermission(Permission.RecordAudio));

    widget.showListening();
    widget.onSearchClick();
    _speech.listen(locale: 'th_TH').then((result) {}).catchError((error) => print(error));
  }

  void cancel() => _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() => _speech.stop().then((result) => setState(() => _isListening = result));

  void onSpeechAvailability(bool result) => setState(() => _speechRecognitionAvailable = result);

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
    _speech.setRecognitionResultHandler((String result) {
      widget.onSearchQueryChanged(result);
      widget.queryController.text = result;
      widget.hideListening();
    });
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.activate().then((res) => setState(() => _speechRecognitionAvailable = res));
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
    } catch (error) {}
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

  Widget buildInitialContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.search,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("ค้นหายาที่ต้องการ")
        ],
      ),
    );
  }

  Widget buildLoadingContent() {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSuccessContent() {
    return new ListView(
      children: buildMedicineItem(),
    );
  }

  Widget buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            FontAwesomeIcons.frown,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("ไม่พบยา")
        ],
      ),
    );
  }

  Widget buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            FontAwesomeIcons.frown,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("มีความผิดพลาดเกิดขึ้น ลองอีกครั้ง")
        ],
      ),
    );
  }
}
