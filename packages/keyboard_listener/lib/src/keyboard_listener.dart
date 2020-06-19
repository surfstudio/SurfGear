import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Колбэк события onChange
typedef KeyboardChangeListener = Function(bool isVisible);

/// Слушатель отображения клавиатуры
class KeyboardListener with WidgetsBindingObserver {
  static final Random _random = Random();

  final Map<String, KeyboardChangeListener> _changeListeners = {};
  final Map<String, VoidCallback> _showListeners = {};
  final Map<String, VoidCallback> _hideListeners = {};

  /// Коллекция слушателей на изменение состояния клавиатуры
  Map<String, KeyboardChangeListener> get changeListeners => _changeListeners;

  /// Коллекция слушателей на отображение клавиатуры
  Map<String, VoidCallback> get showListeners => _showListeners;

  /// Коллекция слушателей на скрытие клавиатуры
  Map<String, VoidCallback> get hideListeners => _hideListeners;

  /// Видна ли клавиатура
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

  /// Колбэк на изменение метрик
  @override
  void didChangeMetrics() {
    _listener();
  }

  /// Добавить слушателя клавиатуры
  /// Возвращает id для слушателя
  ///
  /// [id] - идентификатор слушателя,
  /// назначается автоматически в случае отсутствия
  ///
  /// [onChange] - колбэк на изменение состояния клавиатуры
  ///
  /// [onShow] - колбэк на отображение клавиатуры
  ///
  /// [onHide] - колбэк на скрытие клавиатуры
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

  /// Удалить [onChange] слушатель
  void removeChangeListener(KeyboardChangeListener listener) {
    _removeListener(_changeListeners, listener);
  }

  /// Удалить [onShow] слушатель
  void removeShowListener(VoidCallback listener) {
    _removeListener(_showListeners, listener);
  }

  /// Удалить [onHide] слушатель
  void removeHideListener(VoidCallback listener) {
    _removeListener(_hideListeners, listener);
  }

  /// Удалить [onChange] слушатель по id
  void removeAtChangeListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  /// Удалить [onShow] слушатель по id
  void removeAtShowListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  /// Удалить [onHide] слушатель по id
  void removeAtHideListener(String id) {
    _removeAtListener(_changeListeners, id);
  }

  /// Удалить слушатель по id
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
    // Стандартное поведение:
    // Показалась клавиатруа - bottom был 0 -> стал n
    // Показалась клавиатруа - bottom был n -> стал 0

    // На некоторых устройствах, в виде исключения, может придти:
    // bottom был m -> n, а должен быть 0 -> n
    //
    // Пример:
    // Размер клавиатуры == 280.
    // Вместо 0 => 280 - может придти 480 => 280
    if (isVisibleKeyboard) {
      /// Новая высота больше предыдущей - клавиатура открылась
      _onShow();
      _onChange(true);
    } else {
      /// Новая высота меньше предыдущей - клавиатура закрылась
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
