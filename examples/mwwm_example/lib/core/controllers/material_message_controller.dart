import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm_example/core/controllers/message_controller.dart';
import 'package:surf_util/surf_util.dart';

class MaterialMessageController extends MessageController<MsgType> {
  final BuildContext _context;

  ScaffoldMessengerState? get _state {
    return ScaffoldMessenger.maybeOf(_context);
  }

  MaterialMessageController.from(this._context);

  @override
  void show({required String message, MsgType msgType = MsgType.common}) {
    _state
      ?..removeCurrentSnackBar()
      ..showSnackBar(
        _CustomSnackBar(
          message: message,
        ),
      );
  }
}

class MsgType extends Enum<String> {
  static const commonError = MsgType('commonError');

  static const common = MsgType('common');

  const MsgType(String value) : super(value);
}

class _CustomSnackBar extends SnackBar {
  final String message;
  _CustomSnackBar({required this.message}) : super(content: Text(message));
}
