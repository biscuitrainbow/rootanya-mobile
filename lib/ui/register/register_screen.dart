import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/redux/register/register_screen_state.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:medical_app/ui/common/ripple_button.dart';

class RegisterScreen extends StatefulWidget {
  final Function(User, BuildContext) onRegister;
  final RegisterScreenState registerScreenState;

  RegisterScreen({
    this.onRegister,
    this.registerScreenState,
  });

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController(text: '');
  final TextEditingController passwordController = new TextEditingController(text: '');
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController ageController = new TextEditingController(text: '');
  final TextEditingController weightController = new TextEditingController(text: '');
  final TextEditingController hieghtController = new TextEditingController(text: '');
  final TextEditingController telController = new TextEditingController(text: '');
  final TextEditingController intoleranceController = new TextEditingController(text: '');

  final FocusNode emailFocusNode = new FocusNode();
  final FocusNode passwordFocusNode = new FocusNode();
  final FocusNode barcodeFocusNode = new FocusNode();
  final FocusNode nameFocusNode = new FocusNode();
  final FocusNode ageFocusNode = new FocusNode();
  final FocusNode weightFocusNode = new FocusNode();
  final FocusNode heightFocusNode = new FocusNode();
  final FocusNode telFocusNode = new FocusNode();
  final FocusNode intoleranceFocusNode = new FocusNode();

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
              controller: emailController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกอีเมลล์' : null,
              decoration: const InputDecoration(
                hintText: 'อีเมลล์',
                labelText: 'อีเมลล์',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            new TextFormField(
              controller: passwordController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกรหัสผ่าน' : null,
              decoration: const InputDecoration(
                hintText: 'รหัสผ่าน',
                labelText: 'รหัสผ่าน',
              ),
              obscureText: true,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(nameFocusNode),
            ),
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
              keyboardType: TextInputType.number,
              controller: ageController,
              focusNode: ageFocusNode,
              validator: (val) => val.isEmpty ? 'กรุณากรอกอายุ' : null,
              decoration: const InputDecoration(
                hintText: 'อายุ',
                labelText: 'อายุ',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(weightFocusNode),
            ),
            new TextFormField(
              keyboardType: TextInputType.number,
              controller: weightController,
              focusNode: weightFocusNode,
              validator: (val) => val.isEmpty ? 'กรุณากรอกน้ำหนัก' : null,
              decoration: const InputDecoration(
                hintText: 'น้ำหนัก',
                labelText: 'น้ำหนัก',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(heightFocusNode),
            ),
            new TextFormField(
              keyboardType: TextInputType.number,
              controller: hieghtController,
              focusNode: heightFocusNode,
              validator: (val) => val.isEmpty ? 'กรุณากรอกส่วนสูง' : null,
              decoration: const InputDecoration(
                hintText: 'ส่วนสูง',
                labelText: 'ส่วนสูง',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(telFocusNode),
            ),
            new TextFormField(
              keyboardType: TextInputType.number,
              controller: telController,
              focusNode: telFocusNode,
              //validator: (val) => val.isEmpty ? 'กรุณากรอกอายุ' : null,
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
                  );
                },
              ),
            ),
            Center(
              child: new RippleButton(
                text: "ลงทะเบียน",
                backgroundColor: Theme.of(context).accentColor,
                textColor: Colors.black,
                highlightColor: Colors.grey.shade200,
                onPress: _register,
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
      text: 'กำลังลงทะเบียน',
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: LoadingView(
          loadingStatus: widget.registerScreenState.loadingStatus,
          loadingContent: _buildLoadingContent(),
          initialContent: _buildInitialContent(),
          successContent: _buildSuccessContent(),
          errorContent: _buildErrorContent(),
        ),
      ),
    );
  }

  _register() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    var user = User(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      gender: this.gender,
      age: int.tryParse(ageController.text) ?? null,
      weight: int.tryParse(weightController.text) ?? null,
      height: int.tryParse(hieghtController.text) ?? null,
      tel: telController.text,
      intolerance: intoleranceController.text,
    );

    this.widget.onRegister(user, context);
  }
}
