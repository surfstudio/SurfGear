import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/webpage/header/header_logo_widget.dart';
import 'package:surfgear_webpage/webpage/menu/menu_top_widget.dart';

/// Шапка веб-страницы
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=3%3A0
class HeaderWidget extends StatelessWidget {
  /// Колбэк нажатия на кнопку меню
  final Function onMenuTap;

  /// Контроллер анимации кнопки
  final AnimationController animationController;

  HeaderWidget({
    @required this.animationController,
    @required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Column(
        children: [
          MenuTopWidget(
            animationController,
            onMenuTap,
          ),
          HeaderLogoWidget(),
        ],
      ),
    );
  }
}
