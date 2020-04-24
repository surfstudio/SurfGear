import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Виджет меню
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class MenuButton extends StatelessWidget {
  /// Колбэк нажатия на кнопку меню
  final Function onMenuTap;

  /// Контроллер анимации кнопки
  final AnimationController menuButtonAnimationController;

  MenuButton({
    @required this.menuButtonAnimationController,
    @required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        1.0,
        -1.0,
      ),
      child: IconButton(
        icon: AnimatedIcon(
          color: Colors.white,
          icon: AnimatedIcons.menu_close,
          progress: menuButtonAnimationController,
        ),
        onPressed: onMenuTap,
      ),
    );
  }
}
