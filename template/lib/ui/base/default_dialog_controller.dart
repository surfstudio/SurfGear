/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/ui/base/owners/dialog_owner.dart';
import 'package:flutter_template/ui/common/dialog/alert_dialog.dart';
import 'package:flutter_template/util/enum.dart';
import 'package:mwwm/mwwm.dart';

/// Типы сообщений
class DialogType extends Enum<String> {
  const DialogType(String value) : super(value);

  static const alert = const DialogType('alert');
}

///Стандартная реализация [DialogController]
class DefaultDialogController implements DialogController {
  final GlobalKey<ScaffoldState> _scaffoldState;
  final BuildContext _context;
  final DialogOwner dialogOwner;

  PersistentBottomSheetController _sheetController;

  DefaultDialogController(this._scaffoldState, {this.dialogOwner})
      : _context = null;

  DefaultDialogController.from(this._context, {this.dialogOwner})
      : _scaffoldState = null;

  BuildContext get _scaffoldContext =>
      _scaffoldState?.currentContext ?? Scaffold.of(_context).context;

  @override
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    onAgreeClicked,
    onDisagreeClicked,
  }) {
    return showDialog(
      context: _scaffoldContext,
      builder: (ctx) => PlatformAlertDialog(
        alertText: message,
        onAgreeClicked: () => onAgreeClicked(ctx),
        onDisagreeClicked: () => onDisagreeClicked(ctx),
      ),
    );
  }

  @override
  Future<R> showSheet<R>(type, {VoidCallback onDismiss}) {
    assert(dialogOwner != null);

    if (_scaffoldState == null) {
      _sheetController = showBottomSheet(
        context: _context,
        builder: dialogOwner?.registeredDialogs[type],
      );
    } else {
      _sheetController = _scaffoldState.currentState
          .showBottomSheet(dialogOwner?.registeredDialogs[type]);
    }

    _sheetController.closed.then((_) {
      _sheetController = null;
      onDismiss();
    });
    return _sheetController.closed;
  }

  void hideBottomSheet() {
    assert(dialogOwner != null);

    _sheetController?.close();
  }

  @override
  Future<R> showModalSheet<R>(type, {VoidCallback onDismiss}) {
    assert(dialogOwner != null);

    return showModalBottomSheet(
      context: _scaffoldContext,
      builder: dialogOwner?.registeredDialogs[type],
    );
  }
}

/// Дефолтный диалог выбора даты
class DatePickerDialogController {
  final GlobalKey<ScaffoldState> _scaffoldState;
  final BuildContext _context;

  DatePickerDialogController(this._scaffoldState) : _context = null;

  DatePickerDialogController.from(this._context) : _scaffoldState = null;

  BuildContext get _scaffoldContext =>
      _scaffoldState?.currentContext ?? Scaffold.of(_context).context;

  Stream<DateTime> show({
    DateTime firstDate,
    DateTime lastDate,
    DateTime initialDate,
    Widget iosCloseButton,
    Widget iosDoneButton,
  }) {
    if (Theme.of(_scaffoldContext).platform == TargetPlatform.android) {
      return showDatePicker(
        context: _scaffoldContext,
        firstDate: firstDate ?? DateTime(1900),
        initialDate: initialDate,
        lastDate: lastDate ?? DateTime(2090),
      ).asStream();
    } else {
      StreamController<DateTime> controller = StreamController<DateTime>();
      showCupertinoModalPopup(
        context: _scaffoldContext,
        builder: (ctx) => _buildBottomPicker(
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate ?? DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              controller.add(newDateTime);
            },
          ),
          onCancel: () {
            controller.add(initialDate);
            controller.close();
            Navigator.of(_scaffoldContext, rootNavigator: true).pop();
          },
          onDone: () {
            controller.close();
            Navigator.of(_scaffoldContext, rootNavigator: true).pop();
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
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              iosCloseButton ??
                  CupertinoButton(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Сбросить",
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                    onPressed: onCancel,
                    color: Colors.transparent,
                  ),
              iosDoneButton ??
                  CupertinoButton(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Готово",
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                    onPressed: onDone,
                    color: Colors.transparent,
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
