import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/webpage/menu/menu_button_widget.dart';

/// Меню в виде экрана
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=18%3A0
class MenuScreenWidget extends StatelessWidget {
  /// Колбэк нажатия на кнопку меню
  final Function onMenuTap;

  /// Контроллер анимации кнопки
  final AnimationController menuButtonAnimationController;

  MenuScreenWidget({
    @required this.menuButtonAnimationController,
    @required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: new Color.fromRGBO(0, 0, 0, 0.85),
      ),
      child: Column(
        children: <Widget>[
          MenuButton(
            menuButtonAnimationController: menuButtonAnimationController,
            onMenuTap: onMenuTap,
          ),
          Text(
            "Link1",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Link2",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Link3",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
