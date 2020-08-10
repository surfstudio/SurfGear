import 'package:flutter/material.dart';
import 'package:flutter_template/ui/base/owners/snackbar_owner.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/util/enum.dart';
import 'package:surf_logger/logger.dart';
import 'package:mwwm/mwwm.dart';

///Стандартная реализация [MessageController]
class MaterialMessageController extends MessageController {
  MaterialMessageController(this._scaffoldState, {this.snackOwner})
      : _context = null;

  MaterialMessageController.from(this._context, {this.snackOwner})
      : _scaffoldState = null;

  final GlobalKey<ScaffoldState> _scaffoldState;
  final BuildContext _context;
  final CustomSnackBarOwner snackOwner;

  /// Дефолтные снеки, используются если виджет не определил свои
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

  ScaffoldState get _state =>
      _scaffoldState?.currentState ?? Scaffold.of(_context);

  @override
  void show({String msg, msgType = MsgType.common}) {
    assert(msg != null || msgType != null);

    final owner = snackOwner;
    Logger.d(' SnackBar owner is nul? ${owner == null}');
    SnackBar snack;
    if (owner != null) {
      snack = owner.registeredSnackBarsBuilder[msgType](msg);
    }
    Logger.d(' SnackBar is nul? ${snack == null} by type = $msgType');

    Future.delayed(const Duration(milliseconds: 10), () {
      _state.showSnackBar(
        snack ?? defaultSnackBarBuilder[msgType](msg),
      );
    });
  }
}

/// Типы сообщений
class MsgType extends Enum<String> {
  const MsgType(String value) : super(value);

  static const commonError = MsgType('commonError');
  static const common = MsgType('common');
}
