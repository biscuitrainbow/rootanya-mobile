import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:medical_app/ui/common/ripple_button.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final Function(User, BuildContext) onUpdate;
  final Function(BuildContext context) onLogout;

  ProfileScreen({
    this.user,
    this.onUpdate,
    this.onLogout,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController barcodeController = new TextEditingController(text: '');
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController ageController = new TextEditingController(text: '');
  final TextEditingController weightController = new TextEditingController(text: '');
  final TextEditingController heightController = new TextEditingController(text: '');
  final TextEditingController telController = new TextEditingController(text: '');
  final TextEditingController intoleranceController = new TextEditingController(text: '');
  final TextEditingController diseaseController = new TextEditingController(text: '');
  final TextEditingController medicineController = new TextEditingController(text: '');

  final FocusNode barcodeFocusNode = new FocusNode();
  final FocusNode nameFocusNode = new FocusNode();
  final FocusNode ageFocusNode = new FocusNode();
  final FocusNode weightFocusNode = new FocusNode();
  final FocusNode heightFocusNode = new FocusNode();
  final FocusNode telFocusNode = new FocusNode();
  final FocusNode intoleranceFocusNode = new FocusNode();
  final FocusNode diseaseFocusNode = new FocusNode();
  final FocusNode medicineFocusNode = new FocusNode();

  String gender = 'ชาย';

  Widget _buildInitialContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new TextFormField(
              controller: nameController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกชื่อยา' : null,
              decoration: const InputDecoration(
                hintText: 'ชื่อ - นามสกุล',
                labelText: 'ชื่อ - นามสกุล',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(ageFocusNode),
            ),
            SizedBox(height: 10.0),
            Text(
              'เพศ',
              style: TextStyle(color: Colors.grey, fontSize: 13.0),
            ),
            Row(
              children: <Widget>[
                Text('ชาย'),
                new Radio<String>(value: 'ชาย', groupValue: gender, onChanged: _onGenderChanged),
                Text('หญิง'),
                new Radio<String>(value: 'หญิง', groupValue: gender, onChanged: _onGenderChanged),
              ],
            ),
            new TextFormField(
              controller: ageController,
              focusNode: ageFocusNode,
              validator: (val) {
                if (val.isEmpty) return 'กรุณากรอกชื่อยา';
                if (num.parse(val) > 100) return 'กรุณากรอกอายุให้ถูกต้อง';
              },
              decoration: const InputDecoration(
                hintText: 'อายุ',
                labelText: 'อายุ',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(weightFocusNode),
            ),
            new TextFormField(
              controller: weightController,
              focusNode: weightFocusNode,
              decoration: const InputDecoration(
                hintText: 'น้ำหนัก',
                labelText: 'น้ำหนัก',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(heightFocusNode),
            ),
            new TextFormField(
              controller: heightController,
              focusNode: heightFocusNode,
              decoration: const InputDecoration(
                hintText: 'ส่วนสูง',
                labelText: 'ส่วนสูง',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(telFocusNode),
            ),
            new TextFormField(
              controller: telController,
              focusNode: telFocusNode,
              decoration: const InputDecoration(
                hintText: 'เบอร์โทร',
                labelText: 'เบอร์โทร',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(intoleranceFocusNode),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Builder(
                builder: (BuildContext scaffoldContext) {
                  return new TextFormField(
                    controller: intoleranceController,
                    focusNode: intoleranceFocusNode,
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'ยาที่แพ้',
                      labelText: 'ยาที่แพ้',
                    ),
                    maxLines: 3,
                    onFieldSubmitted: (_) => _save(scaffoldContext),
                  );
                },
              ),
            ),
            SizedBox(height: 24.0),
            new TextFormField(
              controller: diseaseController,
              focusNode: diseaseFocusNode,
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'โรคประจำตัว',
                labelText: 'โรคประจำตัว',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(medicineFocusNode),
            ),
            SizedBox(height: 24.0),
            new TextFormField(
              controller: medicineController,
              focusNode: medicineFocusNode,
              decoration: const InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'ยาที่ใช้ประจำ',
                labelText: 'ยาที่ใช้ประจำ',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(intoleranceFocusNode),
            ),
            Center(
              child: new RippleButton(
                text: "ออกจากระบบ",
                backgroundColor: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).accentColor,
                highlightColor: Colors.grey.shade800,
                onPress: _logout,
              ),
            ),
            SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessContent() {
    return _buildInitialContent();
  }

  Widget _buildLoadingContent() {
    return LoadingContent(
      text: 'กำลังบันทึก',
    );
  }

  Widget _buildErrorContent() {
    return _buildInitialContent();
  }

  void _onGenderChanged(String gender) {
    setState(() {
      this.gender = gender;
    });
  }

  void _save(BuildContext scaffoldContext) {
    var user = User(
      id: widget.user.id,
      name: nameController.text,
      gender: this.gender,
      age: int.parse(ageController.text),
      weight: int.parse(weightController.text),
      height: int.parse(heightController.text),
      tel: telController.text,
      intolerance: intoleranceController.text,
      medicine: medicineController.text,
      disease: diseaseController.text,
    );

    widget.onUpdate(user, scaffoldContext);
  }

  @override
  void initState() {
    var user = widget.user;

    nameController.text = user.name;
    gender = user.gender;
    ageController.text = user.age.toString();
    weightController.text = user.weight.toString();
    heightController.text = user.height.toString();
    medicineController.text = user.medicine;
    diseaseController.text = user.disease;

    telController.text = user.tel.toString();
    intoleranceController.text = user.intolerance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
      floatingActionButton: Builder(
        builder: (BuildContext scaffoldContext) {
          return FloatingActionButton(
            onPressed: () => _save(scaffoldContext),
            child: Icon(Icons.done),
          );
        },
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: LoadingView(
          loadingStatus: LoadingStatus.initial,
          loadingContent: _buildLoadingContent(),
          initialContent: _buildInitialContent(),
          successContent: _buildSuccessContent(),
          errorContent: _buildErrorContent(),
        ),
      ),
    );
  }

  _logout() {
    this.widget.onLogout(context);
  }
}
