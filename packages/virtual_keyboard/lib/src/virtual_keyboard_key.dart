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

import 'package:flutter/widgets.dart';

/// Keyboard key base class
abstract class VirtualKeyboardKey {
  VirtualKeyboardKey({
    required this.widget,
    String? id,
    bool? useAsKey,
    this.keyDecoration,
    this.inkShapeRipple,
    this.inkShapeBorder,
  })  : id = id ?? _r.nextDouble().toString(),
        useAsKey = useAsKey ?? false;

  static final _r = Random();

  /// id keys
  final String id;

  /// Widget for use in a key
  final Widget? widget;

  /// Use Widget instead as a key
  final bool useAsKey;

  /// Key decoration
  final BoxDecoration? keyDecoration;

  /// [ShapeDecoration] for InkWell Effect
  final ShapeDecoration? inkShapeRipple;

  /// [ShapeBorder] for InkWell
  final ShapeBorder? inkShapeBorder;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes , avoid_annotating_with_dynamic
  bool operator ==(dynamic other) {
    // ignore: avoid_dynamic_calls
    return id == other.id;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => id.hashCode;
}

/// Keyboard key with value
abstract class VirtualKeyboardValueKey extends VirtualKeyboardKey {
  VirtualKeyboardValueKey(
    this._value, {
    String? id,
    Widget? widget,
    bool? useAsKey,
    BoxDecoration? keyDecoration,
    ShapeDecoration? inkShapeRipple,
    ShapeBorder? inkShapeBorder,
  }) : super(
          id: id,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
          inkShapeBorder: inkShapeBorder,
        );

  final String _value;

  /// Key value
  String get value => _value;
}

/// Numeric key
class VirtualKeyboardNumberKey extends VirtualKeyboardValueKey {
  VirtualKeyboardNumberKey(
    String value, {
    String? id,
    Widget? widget,
    bool? useAsKey,
    BoxDecoration? keyDecoration,
    ShapeDecoration? inkShapeRipple,
    ShapeBorder? inkShapeBorder,
  }) : super(
          value,
          id: id,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
          inkShapeBorder: inkShapeBorder,
        );

  int? _parsedVale;

  /// Get a numeric representation of the key value
  int? get number => _parsedVale ??= int.tryParse(value);
}

/// Blank dummy key
class VirtualKeyboardEmptyStubKey extends VirtualKeyboardKey {
  VirtualKeyboardEmptyStubKey({String? id, Widget? widget})
      : super(id: id, widget: widget);
}

/// Delete key
class VirtualKeyboardDeleteKey extends VirtualKeyboardKey {
  VirtualKeyboardDeleteKey({
    String? id,
    Widget? widget,
    bool? useAsKey,
    BoxDecoration? keyDecoration,
    ShapeDecoration? inkShapeRipple,
    ShapeBorder? inkShapeBorder,
  }) : super(
          id: id ?? _defaultId,
          widget: widget,
          useAsKey: useAsKey,
          keyDecoration: keyDecoration,
          inkShapeRipple: inkShapeRipple,
          inkShapeBorder: inkShapeBorder,
        );

  static const _defaultId = 'delete';
}
