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
import 'package:mwwm_github_client/model/common/error/network_error_handler.dart';
import 'package:mwwm_github_client/utils/exceptions.dart';

class StandardErrorHandler extends NetworkErrorHandler {
  StandardErrorHandler(
    this._scaffoldKey,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void handleOtherException(Exception exception) {
    _showMessage(exception.toString());
  }

  @override
  void handleNoInternetException(NoInternetException exception) =>
      _showMessage('Интернет не доступен \nПроверьте соединение');

  void _showMessage(String message) {
    _scaffoldKey?.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
