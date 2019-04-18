import 'package:flutter/material.dart';
import 'package:flutter_template/ui/common/dialog/alert_dialog.dart';
import 'package:mwwm/mwwm.dart';

class DefaultDialogController implements DialogController {
  final GlobalKey<ScaffoldState> _scaffoldState;

  DefaultDialogController(this._scaffoldState);

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
