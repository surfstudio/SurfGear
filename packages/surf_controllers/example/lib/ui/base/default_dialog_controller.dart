import 'package:example/ui/base/owners/dialog_owner.dart';
import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

typedef ClickedAction = void Function(BuildContext context);

class DefaultDialogController implements DialogController {
  DefaultDialogController(
    this._scaffoldKey, {
    this.dialogOwner,
  })  : assert(_scaffoldKey != null),
        _context = null;

  DefaultDialogController.from(
    this._context, {
    this.dialogOwner,
  })  : assert(_context != null),
        _scaffoldKey = null;

  final BuildContext _context;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final DialogOwner dialogOwner;

  PersistentBottomSheetController _sheetController;

  BuildContext get context => _context ?? _scaffoldKey.currentContext;

  ScaffoldState get _scaffoldState => _scaffoldKey?.currentState ?? Scaffold.of(_context);

  @override
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    ClickedAction onAgreeClicked,
    ClickedAction onDisagreeClicked,
    bool useRootNavigator = false,
  }) =>
      showDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (ctx) => AlertDialog(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: message != null ? Text(message) : const SizedBox.shrink(),
          actions: <Widget>[
            FlatButton(
              onPressed: () => onDisagreeClicked?.call(ctx),
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () => onAgreeClicked?.call(ctx),
              child: Text('Yes'),
            ),
          ],
        ),
      );

  @override
  Future<R> showModalSheet<R>(
    Object type, {
    DialogData data,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
  }) {
    assert(dialogOwner != null);
    assert(dialogOwner.registeredDialogs.containsKey(type));

    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      builder: (ctx) => dialogOwner.registeredDialogs[type](context, data: data),
    );
  }

  @override
  Future<R> showSheet<R>(
    Object type, {
    VoidCallback onDismiss,
    DialogData data,
  }) {
    assert(dialogOwner != null);
    assert(dialogOwner.registeredDialogs.containsKey(type));

    final dialogBuilder = dialogOwner.registeredDialogs[type];

    final sheetController = _scaffoldState.showBottomSheet<R>(
      (ctx) => dialogBuilder(ctx, data: data),
    );
    _sheetController = sheetController;

    return sheetController.closed.whenComplete(() {
      _sheetController = null;
      onDismiss?.call();
    });
  }

  void hideSheet() {
    _sheetController.close();
  }
}
