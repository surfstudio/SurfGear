

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/res/strings/common_strings.dart';
import 'package:flutter_template/ui/res/text_styles.dart';

///alert диалог, который сам проверяет платформу
class PlatformAlertDialog extends StatelessWidget {
  PlatformAlertDialog({
    this.alertText,
    this.onAgreeClicked,
    this.onDisagreeClicked,
  });

  final String alertText;
  final Function onAgreeClicked;
  final Function onDisagreeClicked;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    return platform == TargetPlatform.iOS
        ? _buildCupertinoDialog()
        : _buildMaterialDialog();
  }

  Widget _buildCupertinoDialog() => CupertinoAlertDialog(
        title: Text(alertText),
        actions: <Widget>[
          onDisagreeClicked != null
              ? FlatButton(
                  child: Text(cancelText),
                  onPressed: onDisagreeClicked,
                )
              : Container(),
          FlatButton(
            child: Text(okText),
            onPressed: onAgreeClicked,
          )
        ],
      );

  Widget _buildMaterialDialog() => AlertDialog(
        title: Text(
          alertText,
          style: textRegular16Grey,
        ),
        actions: <Widget>[
          onDisagreeClicked != null
              ? FlatButton(
                  child: Text(cancelText),
                  onPressed: onDisagreeClicked,
                )
              : Container(),
          FlatButton(
            child: Text(okText),
            onPressed: onAgreeClicked,
          )
        ],
      );
}
