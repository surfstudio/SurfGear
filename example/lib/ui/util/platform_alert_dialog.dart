import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// alert dialog that checks the platform itself
class PlatformAlertDialog extends StatelessWidget {
  PlatformAlertDialog({
    this.alertTitle,
    this.alertContent,
    this.widgetMessage,
    this.onAgreeClicked,
    this.onDisagreeClicked,
    this.okButtonText = 'ok',
    this.cancelButtonText = 'cancel',
  });

  final String alertTitle;
  final String alertContent;
  final Widget widgetMessage;
  final String okButtonText;
  final String cancelButtonText;
  final Function onAgreeClicked;
  final Function onDisagreeClicked;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog();
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: alertTitle != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 11.0),
              child: Text(
                alertTitle,
              ),
            )
          : null,
      content: widgetMessage ?? Text(alertContent),
      actions: <Widget>[
        if (onDisagreeClicked != null)
          FlatButton(
            child: Text(
              cancelButtonText,
            ),
            onPressed: () => onDisagreeClicked(),
          ),
        if (onAgreeClicked != null)
          FlatButton(
            child: Text(
              okButtonText,
            ),
            onPressed: () => onAgreeClicked(),
          )
      ],
    );
  }

  Widget _buildMaterialDialog() => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
        title: alertTitle != null
            ? Text(
                alertTitle,
              )
            : null,
        content: widgetMessage ?? Text(alertContent),
        actions: <Widget>[
          if (onDisagreeClicked != null)
            FlatButton(
              child: Text(
                cancelButtonText,
              ),
              onPressed: () => onDisagreeClicked(),
            ),
          if (onAgreeClicked != null)
            FlatButton(
              child: const Text(
                'ok',
              ),
              onPressed: () => onAgreeClicked(),
            )
        ],
      );
}
