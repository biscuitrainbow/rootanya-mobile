import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/redux/contract/contact_state.dart';
import 'package:medical_app/ui/add_contact/add_contact_container.dart';
import 'package:medical_app/ui/add_contact/edit_contact_container.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  final ContactsState contactState;
  final VoidCallback onRefresh;

  const ContactScreen({Key key, this.contactState, this.onRefresh}) : super(key: key);

  @override
  ContactScreenState createState() {
    return new ContactScreenState();
  }
}

class ContactScreenState extends State<ContactScreen> {
  static final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _startRefreshing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อผู้ติดต่อ'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContact(context),
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () {
          return Future(() {
            widget.onRefresh();
          });
        },
        child: LoadingView(
          loadingStatus: widget.contactState.loadingStatus,
          initialContent: _buildInitialContent(),
          loadingContent: _buildLoadingContent(),
          successContent: _buildSuccessContent(),
          errorContent: _buildSuccessContent(),
        ),
      ),
    );
  }

  void _startRefreshing() async {
//    if (widget.contactState.loadingStatus == LoadingStatus.loading) {
//      _refreshIndicatorKey.currentState.show();
//    }
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
        trailing: IconButton(icon: Icon(Icons.call), onPressed: () => launch("tel://${contact.tel}")),
      );
    });
  }

  List<Widget> _buildContactList() {
    return widget.contactState.contacts.map((contact) => _buildContactItem(contact)).toList();
  }

  _buildInitialContent() {
    return _buildSuccessContent();
  }

  _buildLoadingContent() {
    return LoadingContent(text: 'กำลังโหลด');
  }

  _buildSuccessContent() {
    return ListView(
      children: _buildContactList(),
    );
  }

  _buildErrorContent() {}
}
