import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/ui/base/owners/dialog_owner.dart';
import 'package:flutter_template/ui/common/dialog/alert_dialog.dart';
import 'package:flutter_template/util/enum.dart';
import 'package:mwwm/mwwm.dart';

/// Типы сообщений
class DialogType extends Enum<String> {
  const DialogType(String value) : super(value);

  static const alert = DialogType('alert');
}

///Стандартная реализация [DialogController]
class DefaultDialogController implements DialogController {
  DefaultDialogController(this._scaffoldKey, {this.dialogOwner})
      : assert(_scaffoldKey != null),
        _context = null;

  DefaultDialogController.from(this._context, {this.dialogOwner})
      : assert(_context != null),
        _scaffoldKey = null;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext _context;
  final DialogOwner dialogOwner;

  PersistentBottomSheetController _sheetController;

  BuildContext get context => _context ?? _scaffoldKey.currentContext;

  ScaffoldState get nearestScaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context);

  @override
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    onAgreeClicked,
    onDisagreeClicked,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => PlatformAlertDialog(
        alertText: message,
        onAgreeClicked: () => onAgreeClicked(ctx),
        onDisagreeClicked: () => onDisagreeClicked(ctx),
      ),
    );
  }

  /// Создание кастомного диалога
  Future<R> showCustomAlertDialog<R>(Widget alertDialog) {
    return showDialog(context: context, builder: (ctx) => alertDialog);
  }

  @override
  Future<R> showSheet<R>(Object type,
      {VoidCallback onDismiss, DialogData data}) {
    assert(dialogOwner != null);

    final buildDialog = dialogOwner.registeredDialogs[type];

    final PersistentBottomSheetController<R> sheetController =
        nearestScaffoldState.showBottomSheet<R>(
      (ctx) => buildDialog(ctx, data: data),
    );
    _sheetController = sheetController;

    return sheetController.closed.whenComplete(() {
      _sheetController = null;
      onDismiss?.call();
    });
  }

  Future<R> showFlexibleModalSheet<R>(
    Object type, {
    double minHeight,
    double initHeight,
    double maxHeight,
    bool isCollapsible = true,
    bool isExpand = true,
    bool useRootNavigator = false,
    bool isModal = true,
    List<double> anchors,
    DialogData data,
  }) {
    assert(dialogOwner != null);

    final FlexibleDialogBuilder buildDialog = dialogOwner
        .registeredDialogs[type] as FlexibleDialogBuilder<DialogData>;

    return showFlexibleBottomSheet(
        context: context,
        minHeight: minHeight,
        initHeight: initHeight,
        maxHeight: maxHeight,
        isCollapsible: isCollapsible,
        isExpand: isExpand,
        useRootNavigator: useRootNavigator,
        isModal: isModal,
        anchors: anchors,
        builder: (context, scrollController, offset) {
          return Material(
            child: buildDialog(
              context,
              data: data,
              scrollController: scrollController,
            ),
          );
        });
  }

  void hideBottomSheet() {
    _sheetController?.close();
  }

  @override
  Future<R> showModalSheet<R>(
    Object type, {
    VoidCallback onDismiss,
    DialogData data,
    bool isScrollControlled = false,
  }) {
    assert(dialogOwner != null);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (ctx) => dialogOwner.registeredDialogs[type](ctx, data: data),
    );
  }
}

/// Дефолтный диалог выбора даты
class DatePickerDialogController {
  DatePickerDialogController(this._scaffoldKey)
      : assert(_scaffoldKey != null),
        _context = null;

  DatePickerDialogController.from(this._context)
      : assert(_context != null),
        _scaffoldKey = null;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext _context;

  BuildContext get context => _context ?? _scaffoldKey.currentContext;

  Stream<DateTime> show({
    DateTime firstDate,
    DateTime lastDate,
    DateTime initialDate,
    Widget iosCloseButton,
    Widget iosDoneButton,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showDatePicker(
        context: context,
        firstDate: firstDate ?? DateTime(1900),
        initialDate: initialDate,
        lastDate: lastDate ?? DateTime(2090),
      ).asStream();
    } else {
      final controller = StreamController<DateTime>();
      showCupertinoModalPopup<void>(
        context: context,
        builder: (ctx) => _buildBottomPicker(
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate ?? DateTime.now(),
            onDateTimeChanged: controller.add,
          ),
          onCancel: () {
            controller
              ..add(initialDate)
              ..close();
            Navigator.of(context, rootNavigator: true).pop();
          },
          onDone: () {
            controller.close();
            Navigator.of(context, rootNavigator: true).pop();
          },
          iosCloseButton: iosCloseButton,
          iosDoneButton: iosDoneButton,
        ),
      );
      return controller.stream;
    }
  }

  Widget _buildBottomPicker(
    Widget picker, {
    VoidCallback onCancel,
    VoidCallback onDone,
    Widget iosCloseButton,
    Widget iosDoneButton,
  }) {
    return Container(
      height: 266,
      color: CupertinoColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              iosCloseButton ??
                  CupertinoButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: onCancel,
                    color: Colors.transparent,
                    child: const Text(
                      'Сбросить',
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                  ),
              iosDoneButton ??
                  CupertinoButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: onDone,
                    color: Colors.transparent,
                    child: const Text(
                      'Готово',
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                  ),
            ],
          ),
          Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            color: CupertinoColors.white,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 22.0,
              ),
              child: GestureDetector(
                // Blocks taps from propagating to the modal sheet and popping.
                onTap: () {},
                child: SafeArea(
                  top: false,
                  child: picker,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
