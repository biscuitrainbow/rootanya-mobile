import 'package:flutter/material.dart';
import 'package:rootanya/ui/common/ripple_button.dart';
import 'package:rootanya/ui/login/login_screen.dart';

class NeedLoginScreen extends StatelessWidget {
  void _showLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(LoginScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'กรุณาเข้าสู่ระบบเพื่อเข้าใช้งาน',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          RippleButton(
            text: "เข้าสู่ระบบ",
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.black,
            highlightColor: Colors.grey.shade800,
            onPress: () => _showLoginScreen(context),
          ),
        ],
      ),
    );
  }
}
