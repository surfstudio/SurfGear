import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:flutter_template/ui/common/dialog/alert_dialog.dart';

class MaterialMessageController extends MessageController {
  final GlobalKey<ScaffoldState> _scaffoldState;

  MaterialMessageController(this._scaffoldState);

  @override
  void showSnack(String msg) {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void showAlertDialog({
    String title,
    String message,
    onAgreeClicked,
    onDisagreeClicked,
  }) {
    showDialog(
      context: _scaffoldState.currentContext,
      builder: (ctx) => PlatformAlertDialog(
            alertText: message,
            onAgreeClicked: onAgreeClicked,
            onDisagreeClicked: onDisagreeClicked,
          ),
    );
  }
}
