import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Callback events onChange
typedef KeyboardChangeListener = Function(bool isVisible);

/// Keyboard display listener
class KeyboardListener with WidgetsBindingObserver {
  static final Random _random = Random();

  final Map<String, KeyboardChangeListener> _changeListeners = {};
  final Map<String, VoidCallback> _showListeners = {};
  final Map<String, VoidCallback> _hideListeners = {};

  /// Collection of listeners for changing the state of the keyboard
  Map<String, KeyboardChangeListener> get changeListeners => _changeListeners;

  /// Collection of listeners for keyboard display
  Map<String, VoidCallback> get showListeners => _showListeners;

  /// Collection of listeners to hide the keyboard
  Map<String, VoidCallback> get hideListeners => _hideListeners;

  /// Getter values whether the keyboard is visible
  bool get isVisibleKeyboard =>
      WidgetsBinding.instance.window.viewInsets.bottom > 0;

  KeyboardListener() {
    _init();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _changeListeners.clear();
    _showListeners.clear();
    _hideListeners.clear();
  }

  /// Callback for changing metrics
  @override
  void didChangeMetrics() {
    _listener();
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
    String id,
    KeyboardChangeListener onChange,
    VoidCallback onShow,
    VoidCallback onHide,
  }) {
    assert(onChange != null || onShow != null || onHide != null);
    id ??= _generateId();

    if (onChange != null) _changeListeners[id] = onChange;
    if (onShow != null) _showListeners[id] = onShow;
    if (onHide != null) _hideListeners[id] = onHide;
    return id;
  }

  /// Delete [onChange] listener
  void removeChangeListener(KeyboardChangeListener listener) {
    _removeListener(_changeListeners, listener);
  }

  /// Delete [onShow] listener
  void removeShowListener(VoidCallback listener) {
    _removeListener(_showListeners, listener);
  }

  /// Delete [onHide] listener
  void removeHideListener(VoidCallback listener) {
    _removeListener(_hideListeners, listener);
  }

  /// Delete [onChange] listener by id
  void removeAtChangeListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  /// Delete [onShow] listener by id
  void removeAtShowListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  /// Delete [onHide] listener by id
  void removeAtHideListener(String id) {
    _removeAtListener(_changeListeners, id);
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
    WidgetsBinding.instance.addObserver(this);
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
      _onHide();
      _onChange(false);
    }
  }

  void _onChange(bool isOpen) {
    for (KeyboardChangeListener listener in _changeListeners.values) {
      listener(isOpen);
    }
  }

  void _onShow() {
    for (VoidCallback listener in _showListeners.values) {
      listener();
    }
  }

  void _onHide() {
    for (VoidCallback listener in _hideListeners.values) {
      listener();
    }
  }
}
