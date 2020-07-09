import 'package:flutter/material.dart';
import 'package:mwwm_github_client/utils/exceptions.dart';
import 'package:mwwm_github_client/model/common/error/network_error_handler.dart';

class StandardErrorHandler extends NetworkErrorHandler {
  StandardErrorHandler(
    this._scaffoldKey,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void handleOtherException(Exception exception) {
    _showMessage(exception.toString());
  }

  @override
  void handleNoInternetException(NoInternetException exception) =>
      _showMessage('Интернет не доступен \nПроверьте соединение');

  void _showMessage(String message) {
    _scaffoldKey?.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
