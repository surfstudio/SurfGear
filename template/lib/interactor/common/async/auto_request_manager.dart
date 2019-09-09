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

import 'package:connectivity/connectivity.dart';

final reloadDuration = Duration(seconds: 10);

/// Менеджер автоотправки запроса
///
/// хранит один запрос и пытается его перезапустить
/// для списка запросов либо доработать,
/// либо использовать несколько экземпляров менеджера
///
/// todo можно доработать и использовать напр. doFutureAutoReload(...)
class AutoRequestManager {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _previousConnection;

  Future Function() _autoReloadRequest;
  Timer _requestTimer;

  /// Поставить на автоотправку запрос
  Future<void> autoReload(Future toReload()) async {
    _autoReloadRequest = toReload;
    _tryReload();
  }

  Future<void> dispose() async {
    _autoReloadRequest = null;
    await _connectivitySubscription.cancel();
    _requestTimer.cancel();
  }

  void _tryReload() async {
    await _init();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_reloadRequest);
  }

  void _reloadRequest(ConnectivityResult connection) {
    if (!_needToReload(connection)) return;
    if (_requestTimer != null) _requestTimer.cancel();

    _requestTimer = Timer.periodic(
      reloadDuration,
      (timer) async {
        try {
          await _autoReloadRequest();
          await dispose();
        } catch (e) {
          // ничего не делаем, таймер перезапустит запрос
        }
      },
    );
  }

  bool _needToReload(ConnectivityResult connection) {
    if (!_haveConnection(_previousConnection) && _previousConnection != null) {
      return false;
    }
    return _haveConnection(connection);
  }

  bool _haveConnection(ConnectivityResult connection) {
    switch (connection) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true;
      default:
        return false;
    }
  }

  Future<void> _init() async {
    return _connectivity.checkConnectivity();
  }
}
