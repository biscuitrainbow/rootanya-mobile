import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Function onConfirm;
  final Function onCancel;

  const ConfirmDialog({
    Key key,
    this.onConfirm,
    this.onCancel,
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        new DialogTextButton(
          title: cancelText,
          onPressed: onCancel,
        ),
        new DialogTextButton(
          title: confirmText,
          onPressed: onConfirm,
        ),
      ],
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
