import 'package:flutter/material.dart';
import 'package:virtual_keyboard/src/table_button.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_effect.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_key.dart';

/// On-screen keyboard widget

/// Callback key on the on-screen keyboard
typedef KeyboardPressCallback = void Function(VirtualKeyboardKey keyboardKey);

class VirtualKeyboardWidget extends StatefulWidget {
  const VirtualKeyboardWidget({
    @required this.keyboardKeys,
    Key key,
    this.buttonWidth,
    this.buttonHeight,
    this.onPressKey,
    this.keyTextStyle,
    this.virtualKeyboardEffect,
  }) : super(key: key);

  /// Keyboard data list
  final List<List<VirtualKeyboardKey>> keyboardKeys;

  /// Button Width
  final double buttonWidth;

  /// Button height
  final double buttonHeight;

  /// Callback button click
  final KeyboardPressCallback onPressKey;

  /// Button text textStyle
  final TextStyle keyTextStyle;

  /// Effect of pressing a button
  final VirtualKeyboardEffect virtualKeyboardEffect;

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardWidgetState();
  }
}

class _VirtualKeyboardWidgetState extends State<VirtualKeyboardWidget> {
  List<List<VirtualKeyboardKey>> get _keyboardKeys => widget.keyboardKeys;

  final double _buttonSizeDefault = 36;

  double get _buttonWidth => widget.buttonWidth ?? _buttonSizeDefault;

  double get _buttonHeight => widget.buttonHeight ?? _buttonSizeDefault;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Table(
        children: [
          for (List<VirtualKeyboardKey> line in _keyboardKeys) _buildLine(line)
        ],
      ),
    );
  }

  TableRow _buildLine(List<VirtualKeyboardKey> line) {
    return TableRow(
      children: [
        for (VirtualKeyboardKey keyboardKey in line) _buildKey(keyboardKey)
      ],
    );
  }

  Widget _buildKey(VirtualKeyboardKey keyboardKey) {
    if (keyboardKey.isInstance<VirtualKeyboardEmptyStubKey>()) {
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
    if (keyboardKey.widget != null) return keyboardKey.widget;

    if (keyboardKey.isInstance<VirtualKeyboardValueKey>()) {
      return Text(
        (keyboardKey as VirtualKeyboardValueKey).value,
        style: widget.keyTextStyle,
      );
    } else if (keyboardKey.isInstance<VirtualKeyboardDeleteKey>()) {
      return Text('delete', style: widget.keyTextStyle);
    } else {
      return const SizedBox.shrink();
    }
  }
}
