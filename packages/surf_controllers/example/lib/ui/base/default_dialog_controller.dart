import 'package:example/ui/base/owners/dialog_owner.dart';
import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

typedef ClickedAction = void Function(BuildContext context);

class DefaultDialogController implements DialogController {
  DefaultDialogController(
    this._scaffoldKey, {
    this.dialogOwner,
  });

  DefaultDialogController.from(
    this._context, {
    this.dialogOwner,
  });

  final DialogOwner? dialogOwner;

  BuildContext? _context;
  PersistentBottomSheetController? _sheetController;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  BuildContext? get context => _context ?? _scaffoldKey?.currentContext;

  ScaffoldState get _scaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context!);

  @override
  Future<R?> showAlertDialog<R>({
    String? title,
    String? message,
    ClickedAction? onAgreeClicked,
    ClickedAction? onDisagreeClicked,
    bool useRootNavigator = false,
  }) =>
      showDialog<R>(
        context: context!,
        useRootNavigator: useRootNavigator,
        builder: (ctx) => AlertDialog(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: message != null ? Text(message) : const SizedBox.shrink(),
          actions: <Widget>[
            TextButton(
              onPressed: () => onDisagreeClicked?.call(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => onAgreeClicked?.call(ctx),
              child: const Text('Yes'),
            ),
          ],
        ),
      );

  @override
  Future<R?> showModalSheet<R>(
    Object type, {
    required DialogData data,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
  }) {
    assert(dialogOwner != null);
    assert(dialogOwner!.registeredDialogs.containsKey(type));

    final dialogBuilder = dialogOwner!.registeredDialogs[type]!;

    return showModalBottomSheet<R>(
      context: context!,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      builder: (ctx) => dialogBuilder(ctx, data: data),
    );
  }

  @override
  Future<R> showSheet<R>(
    Object type, {
    required DialogData data,
    VoidCallback? onDismiss,
  }) {
    assert(dialogOwner != null);
    assert(dialogOwner!.registeredDialogs.containsKey(type));

    final dialogBuilder = dialogOwner!.registeredDialogs[type]!;

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
    _sheetController?.close();
  }
}
