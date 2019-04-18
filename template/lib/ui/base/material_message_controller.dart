import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

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
}
