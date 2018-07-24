import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {

  final Function onPress;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color highlightColor;

  const RippleButton({Key key, this.onPress, this.text, this.textColor, this.backgroundColor, this.highlightColor = Colors.orange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 24.0),
     // padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: new Material(
        borderRadius: BorderRadius.all(
          new Radius.circular(5.0),
        ),
        color: backgroundColor,
        child: new InkWell(
          highlightColor: highlightColor,
          splashColor: highlightColor,
          onTap: onPress,
          child: new Center(
            child: new Container(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: new Text(
                text,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
