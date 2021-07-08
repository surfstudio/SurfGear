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

import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Callback events onChange
typedef KeyboardChangeListener = Function(bool isVisible);

/// Keyboard display listener
class KeyboardListener extends WidgetsBindingObserver {
  static final _random = Random();
  final _changeListeners = <String, KeyboardChangeListener>{};
  final _showListeners = <String, VoidCallback>{};
  final _hideListeners = <String, VoidCallback>{};

  /// Collection of listeners for changing the state of the keyboard
  Map<String, KeyboardChangeListener> get changeListeners => _changeListeners;

  /// Collection of listeners for keyboard display
  Map<String, VoidCallback> get showListeners => _showListeners;

  /// Collection of listeners to hide the keyboard
  Map<String, VoidCallback> get hideListeners => _hideListeners;

  /// Getter values whether the keyboard is visible
  bool get isVisibleKeyboard {
    if (WidgetsBinding.instance == null) {
      return false;
    }

    return WidgetsBinding.instance!.window.viewInsets.bottom > 0;
  }

  bool _isKeyboardOpened = false;

  KeyboardListener() {
    _init();
  }

  /// Callback for changing metrics
  @override
  void didChangeMetrics() {
    _listener();
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _changeListeners.clear();
    _showListeners.clear();
    _hideListeners.clear();
  }

  /// Add keyboard listener
  /// Returns the id for the listener
  ///
  /// [id] - listener identifier,
  /// assigned automatically in case of absence
  ///
  /// [onChange] - callback for changing the state of the keyboard
  ///
  /// [onShow] - callback to display the keyboard
  ///
  /// [onHide] - callback to hide the keyboard
  ///
  String addListener({
    String? id,
    KeyboardChangeListener? onChange,
    VoidCallback? onShow,
    VoidCallback? onHide,
  }) {
    assert(onChange != null || onShow != null || onHide != null);
    id ??= _generateId();

    if (onChange != null) _changeListeners[id] = onChange;
    if (onShow != null) _showListeners[id] = onShow;
    if (onHide != null) _hideListeners[id] = onHide;

    return id;
  }

  /// Delete onChange listener
  void removeChangeListener(KeyboardChangeListener listener) {
    _removeListener(_changeListeners, listener);
  }

  /// Delete onShow listener
  void removeShowListener(VoidCallback listener) {
    _removeListener(_showListeners, listener);
  }

  /// Delete onHide listener
  void removeHideListener(VoidCallback listener) {
    _removeListener(_hideListeners, listener);
  }

  /// Delete onChange listener by id
  void removeAtChangeListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  /// Delete onShow listener by id
  void removeAtShowListener(String id) {
    _removeAtListener(_showListeners, id);
  }

  /// Delete onHide listener by id
  void removeAtHideListener(String id) {
    _removeAtListener(_hideListeners, id);
  }

  /// Delete listener by id
  void _removeAtListener(Map<String, Function> listeners, String id) {
    listeners.remove(id);
  }

  void _removeListener(Map<String, Function> listeners, Function listener) {
    listeners.removeWhere((key, value) => value == listener);
  }

  String _generateId() {
    return _random.nextDouble().toString();
  }

  void _init() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void _listener() {
    // Standard behavior:
    // The keyboard appeared - bottom was 0 -> became n
    // The keyboard appeared - bottom was n -> became 0

    // On some devices, as an exception, it may come:
    // bottom was m -> n, and should be 0 -> n
    //
    // Example:
    // Keyboard Size == 280.
    // Instead of 0 => 280 - 480 => 280 may come
    if (isVisibleKeyboard) {
      /// The new height is greater than the previous one
      /// - the keyboard has opened
      _onShow();
      _onChange(true);
    } else {
      /// The new height is less than the previous one
      /// - the keyboard is closed
      if (_isKeyboardOpened) {
        _onHide();
      }

      _onChange(false);
    }
  }

  void _onChange(bool isOpen) {
    _isKeyboardOpened = isOpen;
    for (final listener in _changeListeners.values) {
      listener(isOpen);
    }
  }

  void _onShow() {
    for (final listener in _showListeners.values) {
      listener();
    }
  }

  void _onHide() {
    for (final listener in _hideListeners.values) {
      listener();
    }
  }
}
