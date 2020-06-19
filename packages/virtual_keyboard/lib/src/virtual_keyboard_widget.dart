import 'package:flutter/material.dart';
import 'package:virtual_keyboard/src/table_button.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_effect.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_key.dart';

/// Виджет клавиатуры
/// https://www.figma.com/file/BuQv8izOpGGhRwAcpOt3p3/Thanks-Tab?node-id=1104%3A792

/// Колбэк нажатия на клавишу на экранной клавиатуре
typedef void KeyboardPressCallback(VirtualKeyboardKey keyboardKey);

class VirtualKeyboardWidget extends StatefulWidget {
  /// Данные клавиш клавиатуры
  final List<List<VirtualKeyboardKey>> keyboardKeys;

  /// Ширина кнопки
  final double buttonWidth;

  /// Высота кнопки
  final double buttonHeight;

  final KeyboardPressCallback onPressKey;

  final TextStyle keyTextStyle;

  final VirtualKeyboardEffect virtualKeyboardEffect;

  VirtualKeyboardWidget({
    Key key,
    @required this.keyboardKeys,
    this.buttonWidth,
    this.buttonHeight,
    this.onPressKey,
    this.keyTextStyle,
    this.virtualKeyboardEffect,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardWidgetState();
  }
}

class _VirtualKeyboardWidgetState extends State<VirtualKeyboardWidget> {
  List<List<VirtualKeyboardKey>> get _keyboardKeys => widget.keyboardKeys;

  double _buttonSizeDefault = 36;

  /// Ширина кнопки
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
      child: _buildValueKey(keyboardKey),
      virtualKeyboardEffect: widget.virtualKeyboardEffect,
      useAsKey: keyboardKey.useAsKey,
      keyDecoration: keyboardKey.keyDecoration,
      inkShapeRipple: keyboardKey.inkShapeRipple,
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
      return SizedBox.shrink();
    }
  }
}
