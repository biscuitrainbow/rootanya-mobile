import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rootanya/data/model/contact.dart';
import 'package:rootanya/ui/add_contact/add_contact_container.dart';
import 'package:rootanya/ui/add_contact/edit_contact_container.dart';
import 'package:rootanya/ui/add_edit_usage/add_edit_usage_screen.dart';
import 'package:rootanya/ui/common/loading_content.dart';
import 'package:rootanya/ui/common/loading_view.dart';
import 'package:rootanya/ui/common/need_login.dart';
import 'package:rootanya/ui/common/no_content.dart';
import 'package:rootanya/ui/contact/contact_list_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListScreen extends StatefulWidget {
  final ContactListViewModel viewModel;

  const ContactListScreen({
    this.viewModel,
  });

  @override
  ContactListScreenState createState() {
    return new ContactListScreenState();
  }
}

class ContactListScreenState extends State<ContactListScreen> {
  static final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _startRefreshing();
  }

  void _startRefreshing() async {
//    if (widget.contactState.loadingStatus == LoadingStatus.loading) {
//      _refreshIndicatorKey.currentState.show();
//    }
  }

  Widget _buildDeleteConfirmDialog(Contact contact) {
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
            Navigator.of(context).pop();
            widget.viewModel.onDelete(contact, context);
          },
        ),
      ],
    );
  }

  Widget _buildActionDialog(Contact contact, BuildContext scaffoldContext) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      title: Text(
        'คำสั่งเพิ่มเติม',
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      children: <Widget>[
        SimpleDialogOption(
          child: Text('แก้ไข'),
          onPressed: () {
            Navigator.of(context).pop();
            _showContact(context, contact);
          },
        ),
        SizedBox(height: 8.0),
        SimpleDialogOption(
          child: Text('ลบ'),
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) => _buildDeleteConfirmDialog(contact));
          },
        )
      ],
    );
  }

  void _showAddContact(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddContactContainer()));
  }

  void _showContact(BuildContext context, Contact contact) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditContactContainer(contact: contact)));
  }

  Widget _buildContactItem(Contact contact) {
    return Builder(builder: (BuildContext context) {
      return ListTile(
        onTap: () => _showContact(context, contact),
        title: Text(
          contact.tel,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        subtitle: Text(contact.name),
        trailing: Container(
          width: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Semantics(
                label: 'โทรออก',
                child: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () => launch("tel://${contact.tel}"),
                ),
              ),
              Semantics(
                label: 'เพิ่มเติม',
                child: IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildActionDialog(contact, context),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> _buildContactList() {
    return widget.viewModel.contactsState.contacts.map((contact) => _buildContactItem(contact)).toList();
  }

  _buildInitialContent() {
    return _buildSuccessContent();
  }

  _buildLoadingContent() {
    return LoadingContent(text: 'กำลังโหลด');
  }

  _buildSuccessContent() {
    return widget.viewModel.contactsState.contacts.isNotEmpty ? ListView(children: _buildContactList()) : _buildEmptyContent();
  }

  _buildEmptyContent() {
    return NoContent(
      icon: Icons.person,
      title: 'คุณยังไม่มีรายชื่อผูเ้ติดต่อ',
    );
  }

  _buildErrorContent() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อผู้ติดต่อ'),
      ),
      floatingActionButton: widget.viewModel.isAuthenticated
          ? FloatingActionButton(
              onPressed: () => _showAddContact(context),
              child: Icon(Icons.add),
            )
          : null,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return Future(() {
            widget.viewModel.onRefresh();
          });
        },
        child: widget.viewModel.isAuthenticated
            ? LoadingView(
                loadingStatus: widget.viewModel.contactsState.loadingStatus,
                initialContent: _buildInitialContent(),
                loadingContent: _buildLoadingContent(),
                successContent: _buildSuccessContent(),
                errorContent: _buildSuccessContent(),
              )
            : NeedLoginScreen(),
      ),
    );
  }
}
