import 'package:flutter/material.dart';
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

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController ageController = TextEditingController(text: '');
  final TextEditingController weightController = TextEditingController(text: '');
  final TextEditingController hieghtController = TextEditingController(text: '');
  final TextEditingController telController = TextEditingController(text: '');
  final TextEditingController intoleranceController = TextEditingController(text: '');
  final TextEditingController diseaseController = TextEditingController(text: '');
  final TextEditingController medicineController = TextEditingController(text: '');

//  final TextEditingController emailController =  TextEditingController(text: 'natthapon@mail.com');
//  final TextEditingController passwordController =  TextEditingController(text: '123456');
//  final TextEditingController nameController =  TextEditingController(text: 'Natthapon');
//  final TextEditingController ageController =  TextEditingController(text: '25');
//  final TextEditingController weightController =  TextEditingController(text: '55');
//  final TextEditingController hieghtController =  TextEditingController(text: '175');
//  final TextEditingController telController =  TextEditingController(text: '');
//  final TextEditingController intoleranceController =  TextEditingController(text: '');
//  final TextEditingController diseaseController =  TextEditingController(text: '');
//  final TextEditingController medicineController =  TextEditingController(text: '');

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
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

  Widget _buildInitialContent(BuildContext scaffoldContext) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกอีเมลล์' : null,
              decoration: InputDecoration(
                hintText: 'อีเมลล์',
                labelText: 'อีเมลล์',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            TextFormField(
              controller: passwordController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกรหัสผ่าน' : null,
              decoration: InputDecoration(
                hintText: 'รหัสผ่าน',
                labelText: 'รหัสผ่าน',
              ),
              obscureText: true,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(nameFocusNode),
            ),
            TextFormField(
              controller: nameController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกชื่อยา' : null,
              decoration: InputDecoration(
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
              keyboardType: TextInputType.number,
              controller: ageController,
              focusNode: ageFocusNode,
              // validator: (val) => val.isEmpty ? 'กรุณากรอกอายุ' : null,
              decoration: InputDecoration(
                hintText: 'อายุ',
                labelText: 'อายุ',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(weightFocusNode),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: weightController,
              focusNode: weightFocusNode,
              // validator: (val) => val.isEmpty ? 'กรุณากรอกน้ำหนัก' : null,
              decoration: InputDecoration(
                hintText: 'น้ำหนัก',
                labelText: 'น้ำหนัก',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(heightFocusNode),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: hieghtController,
              focusNode: heightFocusNode,
              // validator: (val) => val.isEmpty ? 'กรุณากรอกส่วนสูง' : null,
              decoration: InputDecoration(
                hintText: 'ส่วนสูง',
                labelText: 'ส่วนสูง',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(telFocusNode),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: telController,
              focusNode: telFocusNode,
              //validator: (val) => val.isEmpty ? 'กรุณากรอกอายุ' : null,
              decoration: InputDecoration(
                hintText: 'เบอร์โทร',
                labelText: 'เบอร์โทร',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(intoleranceFocusNode),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Builder(
                builder: (BuildContext scaffoldContext) {
                  return TextFormField(
                    controller: intoleranceController,
                    focusNode: intoleranceFocusNode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'ยาที่แพ้',
                      labelText: 'ยาที่แพ้',
                    ),
                    maxLines: 3,
                  );
                },
              ),
            ),
            SizedBox(height: 24.0),
            TextFormField(
              controller: diseaseController,
              focusNode: diseaseFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'โรคประจำตัว',
                labelText: 'โรคประจำตัว',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(medicineFocusNode),
            ),
            SizedBox(height: 24.0),
            TextFormField(
              controller: medicineController,
              focusNode: medicineFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ยาที่ใช้ประจำ',
                labelText: 'ยาที่ใช้ประจำ',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(intoleranceFocusNode),
            ),
            Center(
              child: RippleButton(
                text: "ลงทะเบียน",
                backgroundColor: Theme.of(context).accentColor,
                textColor: Colors.black,
                highlightColor: Colors.grey.shade200,
                onPress: () => _register(scaffoldContext),
              ),
            ),
            SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return LoadingContent(
      text: 'กำลังลงทะเบียน',
    );
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
        child: Builder(builder: (BuildContext scaffoldContext) {
          return LoadingView(
            loadingStatus: widget.registerScreenState.loadingStatus,
            loadingContent: _buildLoadingContent(),
            initialContent: _buildInitialContent(scaffoldContext),
            successContent: _buildInitialContent(scaffoldContext),
            errorContent: _buildInitialContent(scaffoldContext),
          );
        }),
      ),
    );
  }

  _register(BuildContext scaffoldContext) {
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
      medicine: medicineController.text ?? null,
      disease: diseaseController.text ?? null,
    );

    this.widget.onRegister(user, scaffoldContext);
  }
}
