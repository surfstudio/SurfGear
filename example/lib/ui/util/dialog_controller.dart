import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/ui/util/platform_alert_dialog.dart';

/// Миксин, добавляющий возможност зарегистрировать диалоги
mixin DialogOwner {
  Map<dynamic, DialogBuilder> get registeredDialogs;
}

class DialogBuilder<T extends DialogData> {
  DialogBuilder(this.builder);

  final Widget Function(BuildContext context, {T data}) builder;

  Widget call(BuildContext context, {T data}) => builder(context, data: data);
}

class DefaultDialogController implements DialogController {
  DefaultDialogController(this._scaffoldState, {this.dialogOwner})
      : _context = null;

  DefaultDialogController.from(this._context, {this.dialogOwner})
      : _scaffoldState = null;

  PersistentBottomSheetController _sheetController;
  final GlobalKey<ScaffoldState> _scaffoldState;
  final BuildContext _context;
  final DialogOwner dialogOwner;

  BuildContext get _scaffoldContext =>
      _context ??
      _scaffoldState?.currentContext ??
      Scaffold.of(_context).context;

  @override
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    Widget widgetMessage,
    String agreeText,
    String cancelText,
    onAgreeClicked,
    onDisagreeClicked,
  }) {
    return showDialog(
      context: _scaffoldContext,
      builder: (ctx) => PlatformAlertDialog(
        alertTitle: title,
        alertContent: message,
        widgetMessage: widgetMessage,
        okButtonText: agreeText,
        cancelButtonText: cancelText,
        onAgreeClicked:
            onAgreeClicked != null ? () => onAgreeClicked(ctx) : null,
        onDisagreeClicked:
            onDisagreeClicked != null ? () => onDisagreeClicked(ctx) : null,
      ),
    );
  }

  @override
  Future<R> showModalSheet<R>(
    type, {
    DialogData data,
    bool isScrollControlled,
  }) {
    assert(dialogOwner != null);

    return showModalBottomSheet(
      context: _scaffoldContext,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (ctx) => dialogOwner?.registeredDialogs[type](ctx, data: data),
    );
  }

  @override
  Future<R> showSheet<R>(type, {onDismiss, DialogData data}) {
    assert(dialogOwner != null);

    final buildDialog = dialogOwner?.registeredDialogs[type];

    if (_scaffoldState == null) {
      _sheetController = showBottomSheet(
        context: _context,
        builder: (ctx) => buildDialog(ctx, data: data),
      );
    } else {
      _sheetController = _scaffoldState.currentState.showBottomSheet(
        (ctx) => buildDialog(ctx, data: data),
      );
    }

    _sheetController.closed.then((_) {
      _sheetController = null;
      if(onDismiss != null) {
        onDismiss();
      }
    });

    return _sheetController.closed;
  }
}
