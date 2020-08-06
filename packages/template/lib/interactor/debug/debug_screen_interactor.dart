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

import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:push_notification/push_notification.dart';

/// Интерактор для работы с <DebugScreen>
class DebugScreenInteractor {
  DebugScreenInteractor(this._pushHandler);

  final PushHandler _pushHandler;

  void showDebugScreenNotification() {
    if (Environment<Config>.instance().isDebug) {
      _pushHandler.handleMessage(
        <String, Object>{
          'notification': {
            'title': 'Open debug screen',
            'body': '',
          },
          'event': 'debug',
          'data': {
            'event': 'debug',
          },
        },
        MessageHandlerType.onMessage,
        localNotification: true,
      );
    }
  }
}
