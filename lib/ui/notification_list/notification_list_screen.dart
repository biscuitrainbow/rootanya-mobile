import 'package:flutter/material.dart';
import 'package:medical_app/data/model/medicine.dart';
import 'package:medical_app/ui/common/loading_content.dart';
import 'package:medical_app/ui/common/loading_view.dart';
import 'package:medical_app/ui/common/need_login.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_container.dart';
import 'package:medical_app/ui/medicine_list/medicine_list_mode.dart';
import 'package:medical_app/ui/notification_list/notification_list_container.dart';

class NotificationListScreen extends StatelessWidget {
  final NotificationListScreenViewModel viewModel;

  const NotificationListScreen({this.viewModel});

  Widget _buildLoadingContent() {
    return LoadingContent(text: 'กำลังโหลด');
  }

  Widget _buildSuccessContent(BuildContext context) {
    return viewModel.notifications.isNotEmpty
        ? ListView(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            children: _buildNotificationGroupItem(context),
          )
        : _buildEmptyContent();
  }

  Widget _buildEmptyContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.alarm,
            size: 46.0,
          ),
          SizedBox(height: 16.0),
          Text("ยังไม่มีการแจ้งเตือน")
        ],
      ),
    );
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.alarm,
          ),
          Text("มีความผิดพลาดเกิดขึ้น ลองอีกครั้ง")
        ],
      ),
    );
  }

  void _showMedicineListPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MedicineListContainer(mode: MedicineListMode.addNotification),
      ),
    );
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  List<Container> _buildNotificationGroupItem(BuildContext context) {
    return viewModel.notifications
        ?.map(
          (Medicine medicine) => Container(
                margin: EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      medicine.name,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Column(
                      children: medicine.notifications
                          .map(
                            (n) => _buildNotificationItem(n, context),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
        )
        ?.toList();
  }

  Padding _buildNotificationItem(dynamic notification, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${_toTwoDigitString(notification.time.hour)}:${_toTwoDigitString(notification.time.minute)}',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).accentColor,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              viewModel.onDelete(notification.uuid);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การแจ้งเตือน'),
      ),
      body: viewModel.isAuthenticated
          ? LoadingView(
              loadingStatus: viewModel.loadingStatus,
              initialContent: _buildSuccessContent(context),
              loadingContent: _buildLoadingContent(),
              successContent: _buildSuccessContent(context),
              errorContent: _buildErrorContent(),
            )
          : NeedLoginScreen(),
      floatingActionButton: viewModel.isAuthenticated
          ? FloatingActionButton(
              onPressed: () => _showMedicineListPage(context),
              child: Icon(Icons.alarm_add),
            )
          : null,
    );
  }
}
