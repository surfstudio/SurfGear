import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:flutter_template/interactor/session/session_changed_interactor.dart';
import 'package:flutter_template/ui/base/error/network_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:flutter_template/ui/res/strings/common_strings.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';

/// Стандартная реализация эррор хендлера
class StandardErrorHandler extends NetworkErrorHandler {
  final MessageController _messageController;
  // ignore: unused_field
  final DialogController _dialogController;
  // ignore: unused_field
  final SessionChangedInteractor _sessionChangedInteractor;

  StandardErrorHandler(
    this._messageController,
    this._dialogController,
    this._sessionChangedInteractor,
  );

  @override
  void handleOtherError(Exception e) {
    if (e is MessagedException) {
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
    if (statusCode == HttpCodes.code403) {
      _show(forbiddenErrorMessage);
    } else if (statusCode == HttpCodes.code404) {
      _show(serverErrorMessage);
    } else {
      _show(defaultHttpErrorMessage);
    }
  }

  void _show(String msg) => _messageController.show(
        msg: msg,
        msgType: MsgType
            .commonError, //todo выделить base модуль для всех в стандарте
      );
}
