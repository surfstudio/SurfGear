// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/ui/util/platform_alert_dialog.dart';

/// Mixin adding the ability to register dialogs
mixin DialogOwner {
  Map<dynamic, DialogBuilder> get registeredDialogs;
}

class DialogBuilder<T extends DialogData> {
  DialogBuilder(this.builder);

  final Widget Function(BuildContext context, {T data}) builder;

  Widget call(BuildContext context, {T data}) => builder(context, data: data);
}

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

  BuildContext get context => _context ?? _scaffoldKey.currentContext;
  ScaffoldState get nearestScaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context);

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
      context: context,
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

  @override
  Future<R> showSheet<R>(type, {VoidCallback onDismiss, DialogData data}) {
    assert(dialogOwner != null);

    final buildDialog = dialogOwner.registeredDialogs[type];

    return nearestScaffoldState
        .showBottomSheet<R>((ctx) => buildDialog(ctx, data: data))
        .closed
        .whenComplete(() => onDismiss?.call());
  }
}
