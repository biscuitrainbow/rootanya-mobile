import 'package:flutter/material.dart';
import 'package:medical_app/data/model/user.dart';
import 'package:medical_app/ui/home/home.dart';
import 'package:medical_app/ui/login/login_container.dart';

class SplashScreen extends StatefulWidget {
  final User user;

  const SplashScreen({this.user});

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  void showHomeScreen() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void showLoginScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginContainer()));
  }

  @override
  void initState() {
    animationController = new AnimationController(duration: Duration(seconds: 4), vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.user == null)
            showLoginScreen();
          else
            showHomeScreen();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icons/med_icon_only.png',
              width: 180.0,
            ),
            Text(
              'รู้ทันยาเพื่อผู้พิการทางสายตา\nและผู้สูงอายุ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.0),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'ได้รับงบประมาณสนับสนุนจาก สำนักงานคณะกรรมการวิจัยแห่งชาติ (ว.ช.) ปี 2561',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/imgs/nrct_logo.jpg',
                      width: 70.0,
                    ),
                    Image.asset(
                      'assets/imgs/camt_logo.jpg',
                      width: 120.0,
                    ),
                    Image.asset(
                      'assets/imgs/pharmacy_logo.png',
                      width: 120.0,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      //  child: new Text(animationController.lastElapsedDuration.inSeconds.toString()),
    );
  }
}
