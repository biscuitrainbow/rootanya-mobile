import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/ui/add_edit_usage/add_usage_container.dart';
import 'package:medical_app/ui/add_medicine/add_medicine_container.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:medical_app/ui/medicine_detail/medicine_detail_screen.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_mode.dart';

import 'package:speech_recognition/speech_recognition.dart';
import 'package:simple_permissions/simple_permissions.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({this.viewModel, this.mode});

  final MedicineListScreenViewModel viewModel;
  final MedicineListMode mode;

  @override
  MedicineListScreenState createState() {
    return new MedicineListScreenState();
  }
}

class MedicineListScreenState extends State<MedicineListScreen> {
  final _queryController = new TextEditingController();
  final _queryFocusNode = FocusNode();
  final _speech = new SpeechRecognition();

  @override
  initState() {
    print(widget.mode);
    super.initState();
    _activateSpeechRecognizer();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _startSpeechRecognizer() async {
    if (!await SimplePermissions.checkPermission(Permission.RecordAudio)) {
      SimplePermissions.requestPermission(Permission.RecordAudio);
    }

    widget.viewModel.showListening();
    widget.viewModel.onSearchClick();
    _speech.listen(locale: 'th_TH').then((result) {}).catchError((error) => print(error));
  }

  void _activateSpeechRecognizer() {
    _speech.setRecognitionResultHandler((String result) {
      widget.viewModel.onQueryChanged(result);
      _queryController.text = result;
      widget.viewModel.hideListening();
    });
  }

  Future _scanBarcode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      _queryController.text = barcode;

      widget.viewModel.onQueryChanged(barcode);
      widget.viewModel.onSearchClick();
    } catch (error) {
      print(error);
    }
  }

  void _showAddHistory(BuildContext context, Medicine medicine) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (BuildContext context) => new AddUsageContainer(medicine: medicine)),
    );
  }

  void _showTimePicker(BuildContext context, Medicine medicine) async {
    var pickedTime = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );

    if (pickedTime != null) {
      var time = new Time(pickedTime.hour, pickedTime.minute, 0);
      widget.viewModel.onAddNotification(time, medicine);
    }
  }

  List<Widget> _buildActions() {
    return [
      !widget.viewModel.isSearching
          ? Semantics(
              label: 'ต้นหายาด้วยตัวอักษร',
              child: new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
                  //  FocusScope.of(context).requestFocus(searchNode);
                  widget.viewModel.onSearchClick();
                },
              ),
            )
          : new Container(),
      !widget.viewModel.isSearching
          ? new IconButton(
              icon: new Icon(Icons.keyboard_voice),
              onPressed: () => _startSpeechRecognizer(),
            )
          : new Container(),
      !widget.viewModel.isSearching
          ? Semantics(
              label: 'ค้นหายาด้วยบาร์โค้ด',
              child: new IconButton(
                icon: new Icon(FontAwesomeIcons.barcode),
                onPressed: () => _scanBarcode(),
              ),
            )
          : new Container(),
      widget.viewModel.isSearching
          ? new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => widget.viewModel.onSearchClick(),
            )
          : new Container(),
    ];
  }

  Widget _buildFloatingActionsButton() {
    return widget.viewModel.isListening
        ? new FloatingActionButton(
            onPressed: () {
              widget.viewModel.hideListening();
              widget.viewModel.onSearchClick();
              _speech.cancel();
            },
            child: new Icon(
              Icons.mic_off,
            ),
          )
        : new FloatingActionButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddMedicineContainer())),
            child: Semantics(
              label: 'เพิ่มข้อมูลยา',
              child: Icon(
                Icons.add,
              ),
            ),
          );
  }

  Widget _buildSearchBox(BuildContext context) {
    return new TextField(
      focusNode: _queryFocusNode,
      controller: _queryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'ค้นหายา...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      onChanged: (String text) {
        widget.viewModel.onQueryChanged(text);
      },
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: 'Kanit',
      ),
    );
  }

  IconButton _buildTrailingByMode(Medicine medicine) {
    switch (widget.mode) {
      case MedicineListMode.browsing:
        return null;
        break;
      case MedicineListMode.addNotification:
        return IconButton(
          onPressed: () => _showTimePicker(context, medicine),
          icon: Icon(Icons.add_alert),
        );
        break;
      case MedicineListMode.addUsage:
        return IconButton(
          onPressed: () => _showAddHistory(context, medicine),
          icon: Icon(Icons.note_add),
        );
        break;
      default:
        return null;
    }
  }

  List<ListTile> _buildMedicineItem() {
    return widget.viewModel.medicines
        .map(
          (medicine) => new ListTile(
                title: new Text(medicine.name),
                trailing: _buildTrailingByMode(medicine),
                onTap: () => _showMedicineDetail(medicine),
              ),
        )
        .toList();
  }

  Future _showMedicineDetail(Medicine medicine) {
    return Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new MedicineDetailScreen(medicine: medicine),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Center(
      child: GestureDetector(
        onTap: () => widget.viewModel.onSearchClick(),
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
      ),
    );
  }

  Widget _buildLoadingContent() {
    return LoadingContent(text: 'กำลังค้นหา');
  }

  Widget _buildSuccessContent() {
    return widget.viewModel.medicines.isNotEmpty ? ListView(children: _buildMedicineItem()) : _buildEmptyContent();
  }

  Widget _buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            FontAwesomeIcons.frown,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          new Text("ไม่พบยาที่คุณค้นหา")
        ],
      ),
    );
  }

  Widget _buildErrorContent() {
    return _buildEmptyContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: widget.viewModel.isSearching ? _buildSearchBox(context) : new Text('ค้นหาข้อมูลยา'),
        actions: _buildActions(),
      ),
      floatingActionButton: _buildFloatingActionsButton(),
      floatingActionButtonLocation: widget.viewModel.isListening ? FloatingActionButtonLocation.centerFloat : FloatingActionButtonLocation.endDocked,
      body: LoadingView(
        loadingStatus: widget.viewModel.loadingStatus,
        initialContent: _buildInitialContent(),
        loadingContent: _buildLoadingContent(),
        successContent: _buildSuccessContent(),
        errorContent: _buildErrorContent(),
      ),
    );
  }
}
