import 'package:flutter/material.dart';
import 'package:rootanya/data/model/user.dart';
import 'package:rootanya/ui/common/loading_content.dart';
import 'package:rootanya/ui/common/loading_view.dart';
import 'package:rootanya/ui/common/need_login.dart';
import 'package:rootanya/ui/common/ripple_button.dart';
import 'package:rootanya/ui/profile/profile_container.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileScreenViewModel viewModel;

  ProfileScreen({
    this.viewModel,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController barcodeController = TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController ageController = TextEditingController(text: '');
  final TextEditingController weightController = TextEditingController(text: '');
  final TextEditingController heightController = TextEditingController(text: '');
  final TextEditingController telController = TextEditingController(text: '');
  final TextEditingController intoleranceController = TextEditingController(text: '');
  final TextEditingController diseaseController = TextEditingController(text: '');
  final TextEditingController medicineController = TextEditingController(text: '');

  final FocusNode barcodeFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode weightFocusNode = FocusNode();
  final FocusNode heightFocusNode = FocusNode();
  final FocusNode telFocusNode = FocusNode();
  final FocusNode intoleranceFocusNode = FocusNode();
  final FocusNode diseaseFocusNode = FocusNode();
  final FocusNode medicineFocusNode = FocusNode();

  String gender = 'ไม่ระบุ';

  Widget _buildInitialContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
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
                Radio<String>(value: 'ชาย', groupValue: gender, onChanged: _onGenderChanged),
                Text('หญิง'),
                Radio<String>(value: 'หญิง', groupValue: gender, onChanged: _onGenderChanged),
                Text('ไม่ระบุ'),
                Radio<String>(value: 'ไม่ระบุ', groupValue: gender, onChanged: _onGenderChanged),
              ],
            ),
            TextFormField(
              controller: ageController,
              focusNode: ageFocusNode,
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.isNotEmpty) {
                  if (num.parse(val) > 100) return 'กรุณากรอกอายุให้ถูกต้อง';
                }
              },
              decoration: const InputDecoration(
                hintText: 'อายุ',
                labelText: 'อายุ',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(weightFocusNode),
            ),
            TextFormField(
              controller: weightController,
              focusNode: weightFocusNode,
              keyboardType: TextInputType.number,
              //  validator: (val) => val.isEmpty ? 'กรุณากรอกน้ำหนัก' : null,
              decoration: const InputDecoration(
                hintText: 'น้ำหนัก',
                labelText: 'น้ำหนัก',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(heightFocusNode),
            ),
            TextFormField(
              controller: heightController,
              focusNode: heightFocusNode,
              keyboardType: TextInputType.number,
              //  validator: (val) => val.isEmpty ? 'กรุณากรอกส่วนสูง' : null,
              decoration: const InputDecoration(
                hintText: 'ส่วนสูง',
                labelText: 'ส่วนสูง',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(telFocusNode),
            ),
            TextFormField(
              controller: telController,
              focusNode: telFocusNode,
              keyboardType: TextInputType.number,
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
                  return TextFormField(
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
            TextFormField(
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
            TextFormField(
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
              child: RippleButton(
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

  void _onGenderChanged(String gender) {
    setState(() {
      this.gender = gender;
    });
  }

  void _save(BuildContext scaffoldContext) {
    var user = User(
      id: widget.viewModel.user.id,
      name: nameController.text,
      gender: this.gender,
      age: int.tryParse(ageController.text) ?? null,
      weight: int.tryParse(weightController.text) ?? null,
      height: int.tryParse(heightController.text) ?? null,
      tel: telController.text ?? null,
      intolerance: intoleranceController.text ?? null,
      medicine: medicineController.text ?? null,
      disease: diseaseController.text ?? null,
    );

    widget.viewModel.onUpdate(user, scaffoldContext);
  }

  @override
  void initState() {
    final user = widget.viewModel.user;

    if (user != null) {
      nameController.text = user.name;
      gender = user.gender;
      ageController.text = user.age != null ? user.age.toString() : '';
      weightController.text = user.weight != null ? user.weight.toString() : '';
      heightController.text = user.height != null ? user.height.toString() : '';
      medicineController.text = user.medicine != null ? user.medicine : '';
      diseaseController.text = user.disease != null ? user.disease : '';

      telController.text = user.tel.toString();
      intoleranceController.text = user.intolerance;
    }

    super.initState();
  }

  @override
  void dispose() {
    barcodeController.dispose();
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    telController.dispose();
    intoleranceController.dispose();
    diseaseController.dispose();
    medicineController.dispose();

    barcodeFocusNode.dispose();
    nameFocusNode.dispose();
    ageFocusNode.dispose();
    weightFocusNode.dispose();
    heightFocusNode.dispose();
    telFocusNode.dispose();
    intoleranceFocusNode.dispose();
    diseaseFocusNode.dispose();
    medicineFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
      floatingActionButton: widget.viewModel.isAuthenticated
          ? Builder(
              builder: (BuildContext scaffoldContext) {
                return FloatingActionButton(
                  onPressed: () => _save(scaffoldContext),
                  child: Icon(Icons.done),
                );
              },
            )
          : null,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: widget.viewModel.isAuthenticated
            ? LoadingView(
                loadingStatus: widget.viewModel.state.loadingStatus,
                loadingContent: LoadingContent(text: 'กำลังบันทึก'),
                initialContent: _buildInitialContent(),
              )
            : NeedLoginScreen(),
      ),
    );
  }

  _logout() {
    this.widget.viewModel.onLogout(context);
  }
}
