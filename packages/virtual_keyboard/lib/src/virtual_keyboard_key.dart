import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:virtual_keyboard/src/parser.dart';

/// Keyboard key base class
abstract class VirtualKeyboardKey {
  static Random _r = Random();

  /// Is [instance] a subtype of [T]
  static bool checkType<T extends VirtualKeyboardKey>(
      VirtualKeyboardKey instance) {
    return instance is T;
  }

  /// id keys
  final String id;

  /// Widget for use in a key
  final Widget widget;

  /// Use Widget instead as a key
  final bool useAsKey;

  /// Key decoration
  final BoxDecoration keyDecoration;

  /// [ShapeDecoration] for InkWell Effect
  final ShapeDecoration inkShapeRipple;

  /// [ShapeBorder] for InkWell
  final ShapeBorder inkShapeBorder;

  VirtualKeyboardKey(
    String id, {
    this.widget,
    bool useAsKey,
    this.keyDecoration,
    this.inkShapeRipple,
    this.inkShapeBorder,
  })  : id = id ?? _r.nextDouble().toString(),
        useAsKey = useAsKey ?? false,
        assert(useAsKey == null || useAsKey != null && widget != null);

  bool operator ==(other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Type check
  bool isInstance<T extends VirtualKeyboardKey>() {
    return checkType<T>(this);
  }
}

/// Keyboard key with value
abstract class VirtualKeyboardValueKey extends VirtualKeyboardKey {
  final String _value;

  /// Key value
  String get value => _value;

  VirtualKeyboardValueKey(
    this._value, {
    String id,
    Widget widget,
    bool useAsKey,
    BoxDecoration keyDecoration,
    ShapeDecoration inkShapeRipple,
    ShapeBorder inkShapeBorder,
  }) : super(
          id,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
          inkShapeBorder: inkShapeBorder,
        );
}

/// Numeric key
class VirtualKeyboardNumberKey extends VirtualKeyboardValueKey {
  int _parsedVale;

  /// Get a numeric representation of the key value
  int get number => _parsedVale ??= parseInt(value);

  VirtualKeyboardNumberKey(
    String value, {
    String id,
    Widget widget,
    bool useAsKey,
    BoxDecoration keyDecoration,
    ShapeDecoration inkShapeRipple,
    ShapeBorder inkShapeBorder,
  }) : super(
          value,
          id: id,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
          inkShapeBorder: inkShapeBorder,
        );
}

/// Blank dummy key
class VirtualKeyboardEmptyStubKey extends VirtualKeyboardKey {
  VirtualKeyboardEmptyStubKey({String id, Widget widget})
      : super(id, widget: widget);
}

/// Delete key
class VirtualKeyboardDeleteKey extends VirtualKeyboardKey {
  static String _defaultId = 'delete';

  VirtualKeyboardDeleteKey({
    String id,
    Widget widget,
    bool useAsKey,
    BoxDecoration keyDecoration,
    ShapeDecoration inkShapeRipple,
    ShapeBorder inkShapeBorder,
  }) : super(
          id ?? _defaultId,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
          inkShapeBorder: inkShapeBorder,
        );
}
