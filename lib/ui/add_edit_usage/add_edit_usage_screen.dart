import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/data/loading_status.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/add_contact/add_contact_state.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';

class AddUsageScreen extends StatefulWidget {
  final AddContactState addUsageState;
  final Function(Medicine, BuildContext) onSave;
  final Function(Contact, BuildContext) onDelete;

  final bool isEditing;
  final Medicine medicine;

  const AddUsageScreen({Key key, this.addUsageState, this.onSave, this.isEditing, this.medicine, this.onDelete}) : super(key: key);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddUsageScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController volumeController = new TextEditingController(text: '');

  final FocusNode nameFocusNode = new FocusNode();
  final FocusNode telFocusNode = new FocusNode();

  @override
  void initState() {
    var usage = widget.medicine;

    if (widget.isEditing) {
      volumeController.text = usage.volume.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'แก้ไขการใช้ยา' : 'เพิ่มการใช้ยา'),
        actions: _buildActions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _save(),
        child: Icon(Icons.done),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: LoadingView(
          loadingStatus: LoadingStatus.initial,
          errorContent: _buildErrorContent(),
          successContent: _buildContent(),
          loadingContent: _buildLoadgingContent(),
          initialContent: _buildInitialContent(),
        ),
      ),
    );
  }

  Widget _buildDeleteConfirmDialog() {
    return AlertDialog(
      title: Text('ต้องการลบ?'),
      content: Text('บันทึกนี้จะถูกลบและไม่สามารถกู้คืนได้'),
      actions: <Widget>[
        new DialogTextButton(
          title: 'ยกเลิก',
          onPressed: () => Navigator.of(context).pop(),
        ),
        new DialogTextButton(
          title: 'ลบ',
          onPressed: () {
            Navigator.of(context).pop();
            // widget.onDelete(widget.medicine, context);
          },
        ),
      ],
    );
  }

  List<dynamic> _buildActions() {
    var actions = [
      IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          _save();
        },
      ),
    ];

    return actions;
  }

  Widget _buildContent() {
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
              validator: (val) => val.isEmpty ? 'กรุณากรอกปริมาณยา' : null,
              decoration: const InputDecoration(
                hintText: 'ชื่อยา',
                labelText: 'ชื่อยา',
              ),
              initialValue: widget.medicine.name,
              enabled: false,
            ),
            new TextFormField(
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: volumeController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกปริมาณยา' : null,
              decoration: const InputDecoration(
                hintText: 'ปริมาณ',
                labelText: 'ปริมาณ',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return _buildContent();
  }

  Widget _buildErrorContent() {
    return _buildContent();
  }

  Widget _buildLoadgingContent() {
    return LoadingContent(
      text: 'กำลังบันทึก',
    );
  }

  _save() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    var medicine = widget.medicine.copyWith(volume: int.parse(volumeController.text));
    widget.onSave(medicine, context);
  }
}

class DialogTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const DialogTextButton({
    @required this.title,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var confirmationStyle = TextStyle(color: Theme.of(context).accentColor);

    return Material(
      borderRadius: BorderRadius.circular(2.0),
      color: Theme.of(context).dialogBackgroundColor,
      child: InkWell(
        onTap: onPressed,
        highlightColor: Theme.of(context).highlightColor,
        splashColor: Theme.of(context).hintColor,
        child: Container(
          constraints: BoxConstraints(minWidth: 55.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 9.0),
          child: Text(
            title,
            style: confirmationStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
