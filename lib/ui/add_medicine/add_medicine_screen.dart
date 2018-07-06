import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/data/network/medicine_repository.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';

class AddMedicineScreen extends StatelessWidget {
  final TextEditingController barcodeController;
  final TextEditingController nameController;
  final TextEditingController ingredientController;
  final TextEditingController categoryController;
  final TextEditingController typeController;
  final TextEditingController forController;
  final TextEditingController howController;
  final TextEditingController warningController;
  final TextEditingController keepingController;
  final TextEditingController forgetController;

  final Function(Medicine) onAddMedicine;
  final LoadingStatus loadingStatus;

  const AddMedicineScreen({
    Key key,
    this.barcodeController,
    this.nameController,
    this.ingredientController,
    this.categoryController,
    this.typeController,
    this.forController,
    this.howController,
    this.warningController,
    this.keepingController,
    this.forgetController,
    this.onAddMedicine,
    this.loadingStatus,
  }) : super(key: key);

  Future<Null> save() async {
    var meidicine = new Medicine(
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

    onAddMedicine(meidicine);
  }

  Widget buildContent() {
    return SingleChildScrollView(
      child: Form(
        child: new Column(
          children: <Widget>[
            new TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'ชื่อยา',
                labelText: 'ชื่อยา',
              ),
            ),
            new TextFormField(
              controller: barcodeController,
              decoration: const InputDecoration(
                hintText: 'รหัสบาร์โค้ด',
                labelText: 'รหัสบาร์โค้ด',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: ingredientController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'ตัวยาสำคัญและปริมาณ',
                  labelText: 'ตัวยาสำคัญและปริมาณ',
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'กลุ่มยา',
                  labelText: 'กลุ่มยา',
                ),
                maxLines: 3,
              ),
            ),
            new TextFormField(
              controller: typeController,
              decoration: const InputDecoration(
                hintText: 'รูปแบบยา',
                labelText: 'รูปแบบยา',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: forController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'สรรพคุณ',
                  labelText: 'สรรพคุณ',
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: howController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'วิธีใช้',
                  labelText: 'วิธีใช้',
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: warningController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'ข้อควรระวัง',
                  labelText: 'ข้อควรระวัง',
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: keepingController,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'การเก็บรักษา',
                  labelText: 'การเก็บรักษา',
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new TextFormField(
                controller: forgetController,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.done),
            onPressed: () => save(),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: new LoadingView(
            loadingStatus: loadingStatus,
            initialContent: buildContent(),
            loadingContent: new LoadingContent(
              text: 'กำลังบันทึก',
            ),
            successContent: buildContent(),
          )),
    );
  }
}
