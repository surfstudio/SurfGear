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

import 'package:flutter/material.dart';
import 'package:flutter_template/ui/base/owners/snackbar_owner.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/util/enum.dart';
import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';

///Стандартная реализация [MessageController]
class MaterialMessageController extends MessageController {
  final GlobalKey<ScaffoldState> _scaffoldState;
  final BuildContext _context;
  final CustomSnackBarOwner snackOwner;

  /// Дефолтные снеки, используются если виджет не определил свои
  final Map<dynamic, SnackBar Function(String text)> defaultSnackBarBuilder = {
    MsgType.commonError: (text) => SnackBar(
          content: Text(text),
          duration: Duration(seconds: 2),
          backgroundColor: colorError,
        ),
    MsgType.common: (text) => SnackBar(
          content: Text(text),
          duration: Duration(seconds: 2),
        ),
  };

  MaterialMessageController(this._scaffoldState, {this.snackOwner})
      : _context = null;

  MaterialMessageController.from(this._context, {this.snackOwner})
      : _scaffoldState = null;

  ScaffoldState get _state =>
      _scaffoldState?.currentState ?? Scaffold.of(_context);

  @override
  void show({String msg, msgType = MsgType.common}) {
    assert(msg != null || msgType != null);

    final owner = snackOwner;
    Logger.d(" SnackBar owner is nul? ${owner == null}");
    SnackBar snack;
    if (owner != null) {
      snack = owner.registeredSnackBarsBuilder[msgType](msg);
    }
    Logger.d(" SnackBar is nul? ${snack == null} by type = $msgType");

    Future.delayed(Duration(milliseconds: 10), () {
      _state.showSnackBar(
        snack ?? defaultSnackBarBuilder[msgType](msg),
      );
    });
  }
}

/// Типы сообщений
class MsgType extends Enum<String> {
  const MsgType(String value) : super(value);

  static const commonError = const MsgType('commonError');
  static const common = const MsgType('common');
}
