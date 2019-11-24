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

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:auto_reload/src/auto_request/base/auto_future_manager.dart';
import 'package:connectivity/connectivity.dart';

const int _defaultMinReloadDurationSeconds = 1;
const int _defaultMaxReloadDurationSeconds = 1800;

/// Manager of automatic sending of request to the server
///
/// each new attempt will pass through a greater amount of time
/// from [_minReloadDurationSeconds] to [_maxReloadDurationSeconds]
/// exponentially increasing
class AutoRequestManager implements AutoFutureManager {
  final int _minReloadDurationSeconds;
  final int _maxReloadDurationSeconds;
  int _currentReloadDuration;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  HashMap _queue = HashMap<String, Future Function()>();
  HashMap _callbacks = HashMap<String, AutoFutureCallback>();

  Timer _requestTimer;

  AutoRequestManager({
    int minReloadDurationSeconds,
    int maxReloadDurationSeconds,
  })  : _minReloadDurationSeconds =
            minReloadDurationSeconds ?? _defaultMinReloadDurationSeconds,
        _maxReloadDurationSeconds =
            maxReloadDurationSeconds ?? _defaultMaxReloadDurationSeconds {
    _currentReloadDuration = minReloadDurationSeconds;
  }

  /// register request for auto reload
  @override
  Future<void> autoReload({
    String id,
    Future toReload(),
    AutoFutureCallback onComplete,
  }) async {
    _queue.putIfAbsent(id, () {
      if (onComplete != null) {
        _callbacks[id] = onComplete;
      }
      return toReload;
    });

    _tryReload();
  }

  /// dispose, when need kill manager
  Future<void> dispose() async {
    _queue.clear();
    _callbacks.clear();
    _queue = _callbacks = null;
    await _connectivitySubscription.cancel();
    _requestTimer.cancel();
  }

  void _tryReload() async {
    await _connectivity.checkConnectivity();
    _connectivitySubscription ??=
        _connectivity.onConnectivityChanged.listen(_reloadRequest);
  }

  void _reloadRequest(ConnectivityResult connection) {
    if (!_needToReload(connection)) return;
    if (_requestTimer != null) return;

    _currentReloadDuration = _minReloadDurationSeconds;

    _reRunTimer();
  }

  void _reRunTimer() {
    _closeTimer();
    _requestTimer = Timer.periodic(
      Duration(seconds: _currentReloadDuration),
      _timerHandler,
    );

    _currentReloadDuration = min(
      _currentReloadDuration * 2,
      _maxReloadDurationSeconds,
    );
  }

  void _closeTimer() {
    _requestTimer?.cancel();
    _requestTimer = null;
  }

  Future<void> _timerHandler(timer) async {
    final List<String> keys = _queue.keys.toList();
    for (String key in keys) {
      try {
        await _handleItemQueue(key);
      } catch (e) {
        // do nothing, the timer will restart request
        print('unsuccessful attempt to execute request with error: $e');
      }
    }

    _queue.isEmpty ? _closeTimer() : _reRunTimer();
  }

  Future<void> _handleItemQueue(String key) async {
    await _queue[key]();
    _queue.remove(key);
    if (!_callbacks.containsKey(key)) {
      return;
    }
    _callbacks[key](key);
    _callbacks.remove(key);
  }

  bool _needToReload(ConnectivityResult connection) {
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
}
