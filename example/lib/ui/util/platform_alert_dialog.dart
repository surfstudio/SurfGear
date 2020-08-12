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

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// alert dialog that checks the platform itself
class PlatformAlertDialog extends StatelessWidget {
  PlatformAlertDialog({
    this.alertTitle,
    this.alertContent,
    this.widgetMessage,
    this.onAgreeClicked,
    this.onDisagreeClicked,
    this.okButtonText = 'ok',
    this.cancelButtonText = 'cancel',
  });

  final String alertTitle;
  final String alertContent;
  final Widget widgetMessage;
  final String okButtonText;
  final String cancelButtonText;
  final Function onAgreeClicked;
  final Function onDisagreeClicked;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog();
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: alertTitle != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 11.0),
              child: Text(
                alertTitle,
              ),
            )
          : null,
      content: widgetMessage ?? Text(alertContent),
      actions: <Widget>[
        if (onDisagreeClicked != null)
          FlatButton(
            child: Text(
              cancelButtonText,
            ),
            onPressed: () => onDisagreeClicked(),
          ),
        if (onAgreeClicked != null)
          FlatButton(
            child: Text(
              okButtonText,
            ),
            onPressed: () => onAgreeClicked(),
          )
      ],
    );
  }

  Widget _buildMaterialDialog() => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
        title: alertTitle != null
            ? Text(
                alertTitle,
              )
            : null,
        content: widgetMessage ?? Text(alertContent),
        actions: <Widget>[
          if (onDisagreeClicked != null)
            FlatButton(
              child: Text(
                cancelButtonText,
              ),
              onPressed: () => onDisagreeClicked(),
            ),
          if (onAgreeClicked != null)
            FlatButton(
              child: const Text(
                'ok',
              ),
              onPressed: () => onAgreeClicked(),
            )
        ],
      );
}
