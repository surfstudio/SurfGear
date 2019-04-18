import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class MaterialErrorHandler extends ErrorHandler {
  final GlobalKey<ScaffoldState> _scaffoldState;

  MaterialErrorHandler(this._scaffoldState);

  @override
  void handleError(Exception e) {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
