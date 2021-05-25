import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

typedef SnackBarBuilder = SnackBar Function(String, SnackBarAction?);

class DefaultMessageController implements MessageController {
  DefaultMessageController(GlobalKey<ScaffoldState> scaffoldKey)
      : _scaffoldKey = scaffoldKey;

  DefaultMessageController.from(BuildContext context) : _context = context;

  BuildContext? _context;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  final _defaultSnackBarBuilder = <MsgType, SnackBarBuilder>{
    MsgType.common: (text, action) => _defaultSnackBar(text, action: action),
    MsgType.error: (text, action) =>
        _defaultSnackBar(text, hasError: true, action: action),
  };

  ScaffoldState get _scaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context!);

  @override
  void show({String? msg, Object? msgType}) {
    _show(type: msgType is MsgType ? msgType : MsgType.common, msg: msg ?? '');
  }

  void _show({
    required MsgType type,
    required String msg,
    SnackBarAction? action,
  }) {
    final builder = _defaultSnackBarBuilder[type];
    if (builder != null) {
      _showBottomSnack(builder(msg, action));
    }
  }

  void _showBottomSnack(SnackBar snack) {
    _scaffoldState
      ..removeCurrentSnackBar() // ignore: deprecated_member_use
      ..showSnackBar(snack); // ignore: deprecated_member_use
  }

  // ignore: avoid-returning-widgets
  static SnackBar _defaultSnackBar(
    String text, {
    bool hasError = false,
    SnackBarAction? action,
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
