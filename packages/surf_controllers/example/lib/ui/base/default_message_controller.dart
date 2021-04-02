import 'package:surf_controllers/surf_controllers.dart';
import 'package:flutter/material.dart';

typedef SnackBarBuilder = Widget Function(String text, SnackBarAction action);

class DefaultMessageController implements MessageController {
  DefaultMessageController(this._scaffoldKey)
      : assert(_scaffoldKey != null),
        _context = null;

  DefaultMessageController.from(this._context)
      : assert(_context != null),
        _scaffoldKey = null;

  final BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  final Map<MsgType, SnackBarBuilder> _defaultSnackBarBuilder = {
    MsgType.common: (text, action) => _defaultSnackBar(text, action: action),
    MsgType.error: (text, action) => _defaultSnackBar(text, hasError: true, action: action),
  };

  ScaffoldState get _scaffoldState => _scaffoldKey?.currentState ?? Scaffold.of(_context);

  @override
  show({
    String msg,
    Object msgType = MsgType.common,
  }) {
    assert(msg != null && msgType != null);

    _show(msg: msg, type: msgType);
  }

  void _show({String msg, MsgType type, SnackBarAction action}) {
    _showBottomSnack(_defaultSnackBarBuilder[type](msg, action));
  }

  void _showBottomSnack(SnackBar snack) {
    _scaffoldState
      ..removeCurrentSnackBar()
      ..showSnackBar(snack);
  }

  static Widget _defaultSnackBar(
    String text, {
    bool hasError = false,
    SnackBarAction action,
  }) {
    return SnackBar(
      content: Text(text),
      backgroundColor: hasError ? Colors.red : Colors.black,
      action: action,
    );
  }
}

enum MsgType {
  common,
  error,
}
