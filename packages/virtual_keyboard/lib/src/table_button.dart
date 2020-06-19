import 'package:flutter/material.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_effect.dart';
import 'package:ink_widget/ink_widget.dart';

class TableButton extends StatelessWidget {
  /// Ширина кнопки
  final double width;

  /// Высота кнопки
  final double height;

  /// Потомок
  final Widget child;

  /// Колбэк нажатия
  final VoidCallback onTap;

  /// Отступ
  final EdgeInsets padding;

  final VirtualKeyboardEffect virtualKeyboardEffect;

  final bool useAsKey;

  final BoxDecoration keyDecoration;
  final ShapeDecoration inkShapeRipple;
  final ShapeBorder inkShapeBorder;

  TableButton({
    this.width,
    this.height,
    this.child,
    this.onTap,
    this.padding,
    this.keyDecoration,
    this.inkShapeRipple,
    this.inkShapeBorder,
    VirtualKeyboardEffect virtualKeyboardEffect,
    bool useAsKey,
  })  : virtualKeyboardEffect =
            virtualKeyboardEffect ?? VirtualKeyboardEffect.none,
        useAsKey = useAsKey ?? false;

  @override
  Widget build(BuildContext context) {
    if (useAsKey) {
      return child;
    }
    return _buildContainer(
      child: Padding(
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height,
          ),
          child: SizedBox(
            width: width,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({Widget child}) {
    switch (virtualKeyboardEffect) {
      case VirtualKeyboardEffect.keyboardRipple:
        return TableRowInkWell(
          onTap: onTap,
          child: Container(
            decoration: keyDecoration,
            child: child,
          ),
        );
      case VirtualKeyboardEffect.keyRipple:
        return InkWidget(
          shape: inkShapeRipple,
          shapeBorder: inkShapeBorder,
          onTap: onTap,
          child: Container(
            decoration: keyDecoration,
            child: Center(
              child: child,
            ),
          ),
        );
      case VirtualKeyboardEffect.none:
      default:
        return GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: keyDecoration,
            child: child,
          ),
        );
    }
  }
}
