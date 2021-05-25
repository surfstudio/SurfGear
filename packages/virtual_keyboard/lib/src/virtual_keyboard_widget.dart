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
import 'package:virtual_keyboard/src/table_button.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_effect.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_key.dart';

// ignore_for_file: avoid-returning-widgets

/// On-screen keyboard widget

/// Callback key on the on-screen keyboard
typedef KeyboardPressCallback = void Function(VirtualKeyboardKey keyboardKey);

class VirtualKeyboardWidget extends StatefulWidget {
  const VirtualKeyboardWidget({
    required this.keyboardKeys,
    Key? key,
    this.buttonWidth,
    this.buttonHeight,
    this.onPressKey,
    this.keyTextStyle,
    this.virtualKeyboardEffect,
  }) : super(key: key);

  /// Keyboard data list
  final List<List<VirtualKeyboardKey>> keyboardKeys;

  /// Button Width
  final double? buttonWidth;

  /// Button height
  final double? buttonHeight;

  /// Callback button click
  final KeyboardPressCallback? onPressKey;

  /// Button text textStyle
  final TextStyle? keyTextStyle;

  /// Effect of pressing a button
  final VirtualKeyboardEffect? virtualKeyboardEffect;

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardWidgetState();
  }
}

class _VirtualKeyboardWidgetState extends State<VirtualKeyboardWidget> {
  static const double _buttonSizeDefault = 36;

  double get _buttonWidth => widget.buttonWidth ?? _buttonSizeDefault;
  double get _buttonHeight => widget.buttonHeight ?? _buttonSizeDefault;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Table(
        children: [
          for (final line in widget.keyboardKeys)
            TableRow(
              children: [
                for (final keyboardKey in line) _buildKey(keyboardKey),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildKey(VirtualKeyboardKey keyboardKey) {
    if (keyboardKey is VirtualKeyboardEmptyStubKey) {
      return const SizedBox.shrink();
    }

    return TableButton(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: _buttonWidth,
      height: _buttonHeight,
      onTap: () => widget.onPressKey?.call(keyboardKey),
      virtualKeyboardEffect: widget.virtualKeyboardEffect,
      useAsKey: keyboardKey.useAsKey,
      keyDecoration: keyboardKey.keyDecoration,
      inkShapeRipple: keyboardKey.inkShapeRipple,
      inkShapeBorder: keyboardKey.inkShapeBorder,
      child: _buildValueKey(keyboardKey),
    );
  }

  Widget _buildValueKey(VirtualKeyboardKey keyboardKey) {
    if (keyboardKey.widget != null) {
      return keyboardKey.widget!;
    }

    if (keyboardKey is VirtualKeyboardValueKey) {
      return Text(keyboardKey.value, style: widget.keyTextStyle);
    } else if (keyboardKey is VirtualKeyboardDeleteKey) {
      return Text('delete', style: widget.keyTextStyle);
    } else {
      return const SizedBox.shrink();
    }
  }
}
