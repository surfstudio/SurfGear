import 'package:flutter/material.dart';
import 'package:flutter_template/ui/base/owners/snackbar_owner.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/util/enum.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:mwwm/mwwm.dart';

/// Standard implementation of [MessageController]
/// running on ScaffoldMessengerState
/// https://flutter.dev/docs/release/breaking-changes/scaffold-messenger
///
/// Snacks receive context not from the current State, but from MaterialApp
/// This allows the snack to be displayed between screen transitions
///
/// usage
/// final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
/// GlobalKey<ScaffoldMessengerState>();
/// MaterialApp(
///   scaffoldMessengerKey: rootScaffoldMessengerKey,
///   home: ...
/// )
///
/// rootScaffoldMessengerKey.currentState.showSnackBar(mySnackBar);
class MaterialAppMessageController extends MessageController {
  MaterialAppMessageController(this._scaffoldMessengerKey, {this.snackOwner})
      : _context = null;

  MaterialAppMessageController.from(this._context, {this.snackOwner})
      : _scaffoldMessengerKey = null;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  final BuildContext _context;
  final CustomSnackBarOwner snackOwner;

  /// Default snack
  final Map<MsgType, SnackBar Function(String text)> defaultSnackBarBuilder = {
    MsgType.commonError: (text) => SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
          backgroundColor: colorError,
        ),
    MsgType.common: (text) => SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
        ),
  };

  ScaffoldMessengerState get _state =>
      _scaffoldMessengerKey?.currentState ?? ScaffoldMessenger.of(_context);

  @override
  void show({String msg, Object msgType = MsgType.common}) {
    assert(msg != null || msgType != null);

    final owner = snackOwner;
    SnackBar snack;
    if (owner != null) {
      snack = owner.registeredSnackBarsBuilder[msgType](msg);
    }

    Future.delayed(const Duration(milliseconds: 10), () {
      _state.showSnackBar(
        snack ?? defaultSnackBarBuilder[msgType](msg),
      );
    });
  }
}

/// Message types
class MsgType extends Enum<String> {
  const MsgType(String value) : super(value);

  static const commonError = MsgType('commonError');
  static const common = MsgType('common');
}
