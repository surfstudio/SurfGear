import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/core/controllers/material_message_controller.dart';
import 'package:mwwm_example/core/controllers/message_controller.dart';

class StandardErrorHandler extends ErrorHandler {
  final MessageController messageController;

  StandardErrorHandler(this.messageController);

  @override
  void handleError(Object e) {
    _show(e.toString());
  }

  void _show(String message) => messageController.show(
        message: message,
        msgType: MsgType.commonError,
      );
}
