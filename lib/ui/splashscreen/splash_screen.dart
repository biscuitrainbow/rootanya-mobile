import 'package:flutter/material.dart';
import 'package:medical_app/ui/home/home.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;

  const SplashScreen({this.duration});

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  void showHomeScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new HomeScreen()));
  }

  @override
  void initState() {
    animationController = new AnimationController(duration: widget.duration, vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
              showHomeScreen();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return new Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'รู้ทันยาเพื่อผู้พิการทางสายตา\nและผู้สูงอายุ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 26.0,
                ),
                Text(
                  'ได้รับงบประมาณสนับสนุนจาก สำนักงานคณะกรรมการวิจัยแห่งชาติ (ว.ช.) ปี 2561',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                )
              ],
            ),
          ),
          //  child: new Text(animationController.lastElapsedDuration.inSeconds.toString()),
        );
      },
    );
  }
}
