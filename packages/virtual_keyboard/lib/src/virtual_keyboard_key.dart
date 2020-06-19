import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:virtual_keyboard/src/parser.dart';

/// Базовый класс клавиши клавиатуры
abstract class VirtualKeyboardKey {
  static Random _r = Random();

  /// Является ли [instance] подтипом [T]
  static bool checkType<T extends VirtualKeyboardKey>(
      VirtualKeyboardKey instance) {
    return instance is T;
  }

  /// id клавиши
  final String id;

  final Widget widget;
  final bool useAsKey;
  final BoxDecoration keyDecoration;
  final ShapeDecoration inkShapeRipple;

  VirtualKeyboardKey(
    String id, {
    this.widget,
    bool useAsKey,
    this.keyDecoration,
    this.inkShapeRipple,
  })  : id = id ?? _r.nextDouble().toString(),
        useAsKey = useAsKey ?? false,
        assert(useAsKey == null || useAsKey != null && widget != null);

  bool operator ==(other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Проверка на тип
  bool isInstance<T extends VirtualKeyboardKey>() {
    return checkType<T>(this);
  }
}

/// Клавиша клавиатуры со значением
abstract class VirtualKeyboardValueKey extends VirtualKeyboardKey {
  final String _value;

  /// Значение клавиши
  String get value => _value;

  VirtualKeyboardValueKey(
    this._value, {
    String id,
    Widget widget,
    bool useAsKey,
    BoxDecoration keyDecoration,
    ShapeDecoration inkShapeRipple,
  }) : super(
          id,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
        );
}

/// Числовая клавиша заглушка
class VirtualKeyboardNumberKey extends VirtualKeyboardValueKey {
  int _parsedVale;

  /// Получить числовое представление значения клавиши
  int get number => _parsedVale ??= parseInt(value);

  VirtualKeyboardNumberKey(
    String value, {
    String id,
    Widget widget,
    bool useAsKey,
    BoxDecoration keyDecoration,
    ShapeDecoration inkShapeRipple,
  }) : super(
          value,
          id: id,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
        );
}

/// Пустая клавиша заглушка
class VirtualKeyboardEmptyStubKey extends VirtualKeyboardKey {
  VirtualKeyboardEmptyStubKey({String id, Widget widget})
      : super(id, widget: widget);
}

/// Клавиша удалить
class VirtualKeyboardDeleteKey extends VirtualKeyboardKey {
  static String _defaultId = 'delete';

  VirtualKeyboardDeleteKey({
    String id,
    Widget widget,
    bool useAsKey,
    BoxDecoration keyDecoration,
    ShapeDecoration inkShapeRipple,
  }) : super(
          id ?? _defaultId,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
        );
}
