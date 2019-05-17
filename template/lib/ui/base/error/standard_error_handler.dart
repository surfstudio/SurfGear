import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:flutter_template/ui/base/error/network_error_handler.dart';
import 'package:flutter_template/ui/res/strings/common_strings.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

/// Стандартная реализация эррор хендлера
class StandardErrorHandler extends NetworkErrorHandler {
  final MessageController _messageController;
  final DialogController _dialogController;

  StandardErrorHandler(
    this._messageController,
    this._dialogController,
  );

  @override
  void handleOtherError(Exception e) {
    if (e is UserNotFoundException) {
      _dialogController.showAlertDialog(
        message: userNotFoundText,
        onAgreeClicked: () async {
          //todo переход по разлогину
        },
      );
    } else if (e is OtpException) {
      print("DEV_ERROR $e");
    } else if (e is MessagedException) {
      _show(e.message);
    } else {
      _show(commonErrorText);
    }
  }

  @override
  void handleHttpProtocolException(HttpProtocolException e) {
    if (e is ServerHttpException) {
      _show(serverErrorMessage);
    } else if (e is ClientHttpException) {
      _handleClientHttpException(e);
    }
  }

  @override
  void handleConversionError(ConversionException e) =>
      _show(badResponseErrorMessage);

  @override
  void handleNoInternetError(NoInternetException e) =>
      _show(noInternetConnectionErrorMessage);

  void _handleClientHttpException(ClientHttpException e) {
    final statusCode = e.response.statusCode;
    if (statusCode == HttpCodes.CODE_403) {
      _show(forbiddenErrorMessage);
    } else if (statusCode == HttpCodes.CODE_404) {
      _show(serverErrorMessage);
    } else {
      _show(defaultHttpErrorMessage);
    }
  }

  void _show(String msg) => _messageController.showSnack(msg);
}
