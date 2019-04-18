import 'package:flutter_template/interactor/common/exceptions.dart';
import 'package:flutter_template/ui/res/strings.dart';
import 'package:mwwm/mwwm.dart';

/// Стандартная реализация эррор хендлера
/// todo добавить обработку стандартных ошибок типа остутствия интернета
class StandardErrorHandler extends ErrorHandler {
  final MessageController _messageController;
  final DialogController _dialogController;

  StandardErrorHandler(
    this._messageController,
    this._dialogController,
  );

  @override
  void handleError(Exception e) {
    print("DEV_ERROR ${e.toString()}");

    if (_messageController == null) return;

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
      _messageController.showSnack(e.message);
    } else {
      _messageController.showSnack(commonErrorText);
    }
  }
}
