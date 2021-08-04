import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class AppErrorHandler implements ErrorHandler {
  final BuildContext context;
  AppErrorHandler({
    required this.context,
  });

  void handleError(Object e) {
    final snackBar = SnackBar(content: Text(e.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
