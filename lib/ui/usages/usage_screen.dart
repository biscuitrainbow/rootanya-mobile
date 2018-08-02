import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/data/model/contact.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/redux/usages/usage_state.dart';
import 'package:medical_app/ui/add_contact/add_contact_container.dart';
import 'package:medical_app/ui/add_contact/edit_contact_container.dart';
import 'package:medical_app/ui/add_edit_usage/edit_usage_container.dart';
import 'package:medical_app/ui/common/confirm_dialog.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:medical_app/ui/common/no_content.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_mode.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

class UsageScreen extends StatefulWidget {
  final UsageState usageState;
  final VoidCallback onRefresh;
  final Function(String, BuildContext) onDelete;

  const UsageScreen({
    Key key,
    this.usageState,
    this.onRefresh,
    this.onDelete,
  }) : super(key: key);

  @override
  UsageScreenState createState() {
    return new UsageScreenState();
  }
}

class UsageScreenState extends State<UsageScreen> {
  static final _refreshIndicatorKey = const Key('__REFRESH_USAGE_KEY');

  @override
  void initState() {
    super.initState();

    _startRefreshing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกการใช้ยา'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUsage(context),
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
          loadingStatus: widget.usageState.loadingStatus,
          initialContent: _buildInitialContent(),
          loadingContent: _buildLoadingContent(),
          successContent: _buildSuccessContent(),
          errorContent: _buildSuccessContent(),
        ),
      ),
    );
  }

  void _startRefreshing() async {
//    if (widget.usageState.loadingStatus == LoadingStatus.loading) {
//      _refreshIndicatorKey.currentState.show();
//    }
  }

  void _showEditUsage(Medicine usage) {
    Navigator.of(context).pop();

    Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => EditUsageContainer(usage: usage),
        ));
  }

  Widget _buildConfirmDialog(Medicine usage, BuildContext scaffoldContext) {
    return ConfirmDialog(
      title: 'ต้องการลบบันทึกนี้ ?',
      message: 'บันทึกนี้จะหายไปและไม่สามารถกู้คืนได้',
      confirmText: 'ลบ',
      cancelText: 'ยกเลิก',
      onConfirm: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        widget.onDelete(usage.usageId, scaffoldContext);
      },
      onCancel: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildActionDialog(Medicine usage, BuildContext scaffoldContext) {
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
          onPressed: () => _showEditUsage(usage),
        ),
        SizedBox(height: 8.0),
        SimpleDialogOption(
          child: Text('ลบ'),
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) => _buildConfirmDialog(usage, scaffoldContext));
          },
        )
      ],
    );
  }

  void _showAddUsage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MedicineListContainer(mode: MedicineListMode.addUsage)));
  }

  _buildInitialContent() {
    return _buildSuccessContent();
  }

  _buildLoadingContent() {
    return LoadingContent(text: 'กำลังโหลด');
  }

  _buildSuccessContent() {
    var usages = widget.usageState.usages.reversed.toList();

    if (usages.isEmpty)
      return NoContent(
        title: 'คุณยังไม่มีบันทึกการใช้ยา',
      );

    return SideHeaderListView(
      itemCount: usages.length,
      itemExtend: 70.0,
      headerBuilder: (BuildContext context, index) {
        var usage = usages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              new Text(
                new DateFormat('d').format(usage.usageDate),
                style: new TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              new Text(
                new DateFormat('MMM').format(usage.usageDate),
                style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        );
      },
      itemBuilder: (BuildContext context, index) {
        var usage = usages[index];

        return Builder(builder: (BuildContext scaffoldContext) {
          return ListTile(
            title: Text(
              usage.name,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'ปริมาณ : ${usage.volume.toString()}',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildActionDialog(usage, scaffoldContext),
                  ),
            ),
          );
        });
      },
      hasSameHeader: (int a, int b) {
        var usageA = usages[a];
        var usageB = usages[b];

        return '${usageA.usageDate.day} ${usageA.usageDate.month}' == '${usageB.usageDate.day} ${usageB.usageDate.month}';
      },
    );
  }

  _buildErrorContent() {}
}
