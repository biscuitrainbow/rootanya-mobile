import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/redux/add_contact/add_contact_state.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';

class AddContactScreen extends StatefulWidget {
  final AddContactState addContactState;
  final Function(Contact, BuildContext) onSave;
  final Function(Contact, BuildContext) onDelete;

  final bool isEditing;
  final Contact contact;

  const AddContactScreen({Key key, this.addContactState, this.onSave, this.isEditing, this.contact, this.onDelete}) : super(key: key);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController(text: '');
  final TextEditingController telController = new TextEditingController(text: '');

  final FocusNode nameFocusNode = new FocusNode();
  final FocusNode telFocusNode = new FocusNode();

  @override
  void initState() {
    var contact = widget.contact;

    if (widget.isEditing && contact != null) {
      nameController.text = contact.name;
      telController.text = contact.tel;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'แก้ไขผู้ติดต่อ' : 'เพิ่มผู้ติดต่อ'),
        actions: _buildActions(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: LoadingView(
          loadingStatus: widget.addContactState.loadingStatus,
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
      content: Text('เบอร์โทรนี้จะถูกลบและไม่สามารถกู้คืนได้'),
      actions: <Widget>[
        new DialogTextButton(
          title: 'ยกเลิก',
          onPressed: () => Navigator.of(context).pop(),
        ),
        new DialogTextButton(
          title: 'ลบ',
          onPressed: () {
            Navigator.of(context).pop();
            widget.onDelete(widget.contact, context);
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
          if (!_formKey.currentState.validate()) {
            return;
          }

          var contact = Contact(id: widget.isEditing ? widget.contact.id : null, name: nameController.text, tel: telController.text);
          widget.onSave(contact, context);
        },
      ),
    ];

    if (widget.isEditing) {
      actions.add(
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) => _buildDeleteConfirmDialog());
          },
        ),
      );
    }

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
              controller: nameController,
              validator: (val) => val.isEmpty ? 'กรุณากรอกชื่อยา' : null,
              decoration: const InputDecoration(
                hintText: 'ชื่อ',
                labelText: 'ชื่อ',
              ),
              autofocus: true,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(telFocusNode),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: new TextFormField(
                    validator: (val) => val.isEmpty ? 'กรุณากรอกเบอร์โทร' : null,
                    keyboardType: TextInputType.phone,
                    controller: telController,
                    focusNode: telFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'เบอร์โทร',
                      labelText: 'เบอร์โทร',
                    ),
                  ),
                ),
              ],
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
