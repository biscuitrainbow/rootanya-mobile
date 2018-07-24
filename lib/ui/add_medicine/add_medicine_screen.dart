import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';

class AddMedicineScreen extends StatefulWidget {
  final Function(BuildContext, Medicine) onAddMedicine;
  final LoadingStatus loadingStatus;

  const AddMedicineScreen({
    Key key,
    this.onAddMedicine,
    this.loadingStatus,
  }) : super(key: key);

  @override
  AddMedicineScreenState createState() {
    return new AddMedicineScreenState();
  }
}

class AddMedicineScreenState extends State<AddMedicineScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController barcodeController = new TextEditingController(text: '');
  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController ingredientController = new TextEditingController(text: '');
  final TextEditingController categoryController = new TextEditingController(text: ' ');
  final TextEditingController typeController = new TextEditingController(text: '');
  final TextEditingController forController = new TextEditingController(text: '');
  final TextEditingController howController = new TextEditingController(text: '');
  final TextEditingController warningController = new TextEditingController(text: '');
  final TextEditingController keepingController = new TextEditingController(text: '');
  final TextEditingController forgetController = new TextEditingController(text: '');

  final FocusNode barcodeFocusNode = new FocusNode();
  final FocusNode nameFocusNode = new FocusNode();
  final FocusNode ingredientFocusNode = new FocusNode();
  final FocusNode categoryFocusNode = new FocusNode();
  final FocusNode typeFocusNode = new FocusNode();
  final FocusNode forFocusNode = new FocusNode();
  final FocusNode howFocusNode = new FocusNode();
  final FocusNode warningFocusNode = new FocusNode();
  final FocusNode keepingFocusNode = new FocusNode();
  final FocusNode forgetFocusNode = new FocusNode();

  bool isDirty = false;

  Future<Null> save(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    var medicine = new Medicine(
      name: nameController.text,
      barcode: barcodeController.text,
      ingredient: ingredientController.text,
      category: categoryController.text,
      type: typeController.text,
      fors: forController.text,
      method: howController.text,
      notice: warningController.text,
      keeping: keepingController.text,
      forget: forController.text,
      userId: '1',
    );

    widget.onAddMedicine(context, medicine);
  }

  void scanBarcode() async {
    var barcode = await BarcodeScanner.scan();
    barcodeController.text = barcode;
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidate: true,
        onWillPop: () {
          return Future(() => true);
        },
        child: new Column(
          children: <Widget>[
            new TextFormField(
              controller: nameController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกชื่อยา' : null,
              decoration: const InputDecoration(
                hintText: 'ชื่อยา',
                labelText: 'ชื่อยา',
              ),
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(barcodeFocusNode),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: new TextFormField(
                    controller: barcodeController,
                    focusNode: barcodeFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'รหัสบาร์โค้ด',
                      labelText: 'รหัสบาร์โค้ด',
                    ),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(ingredientFocusNode),
                  ),
                ),
                Semantics(
                  label: 'สแกนจากบาร์โค้ด',
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.camera),
                    onPressed: () => scanBarcode(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: ingredientController,
                focusNode: ingredientFocusNode,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'ตัวยาสำคัญและปริมาณ',
                  labelText: 'ตัวยาสำคัญและปริมาณ',
                ),
                maxLines: 3,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(categoryFocusNode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: categoryController,
                focusNode: categoryFocusNode,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'กลุ่มยา',
                  labelText: 'กลุ่มยา',
                ),
                maxLines: 3,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(typeFocusNode),
              ),
            ),
            new TextFormField(
              controller: typeController,
              decoration: const InputDecoration(
                hintText: 'รูปแบบยา',
                labelText: 'รูปแบบยา',
              ),
              focusNode: typeFocusNode,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(forFocusNode),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: forController,
                focusNode: forFocusNode,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'สรรพคุณ',
                  labelText: 'สรรพคุณ',
                ),
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(howFocusNode),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: howController,
                focusNode: howFocusNode,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'วิธีใช้',
                  labelText: 'วิธีใช้',
                ),
                maxLines: 3,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(warningFocusNode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: warningController,
                focusNode: warningFocusNode,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'ข้อควรระวัง',
                  labelText: 'ข้อควรระวัง',
                ),
                maxLines: 3,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(keepingFocusNode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                focusNode: keepingFocusNode,
                controller: keepingController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'การเก็บรักษา',
                  labelText: 'การเก็บรักษา',
                ),
                maxLines: 3,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(forgetFocusNode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: forgetController,
                focusNode: forgetFocusNode,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'กรณีลืมใช้ยา',
                  labelText: 'กรณีลืมใช้ยา',
                ),
                maxLines: 3,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    barcodeController.dispose();
    nameController.dispose();
    ingredientController.dispose();
    categoryController.dispose();
    typeController.dispose();
    forController.dispose();
    howController.dispose();
    warningController.dispose();
    keepingController.dispose();
    forgetController.dispose();

    barcodeFocusNode.dispose();
    nameFocusNode.dispose();
    ingredientFocusNode.dispose();
    categoryFocusNode.dispose();
    typeFocusNode.dispose();
    forFocusNode.dispose();
    howFocusNode.dispose();
    warningFocusNode.dispose();
    keepingFocusNode.dispose();
    forgetFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) => Semantics(
                  label: 'บันทึก',
                  child: new IconButton(
                    icon: new Icon(Icons.done),
                    onPressed: () => save(context),
                  ),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () => save(context),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: new LoadingView(
            loadingStatus: widget.loadingStatus,
            initialContent: buildContent(),
            loadingContent: new LoadingContent(
              text: 'กำลังบันทึก',
            ),
            successContent: buildContent(),
          )),
    );
  }
}
