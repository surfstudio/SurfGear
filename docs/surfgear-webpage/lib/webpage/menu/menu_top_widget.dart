import 'package:flutter/cupertino.dart';
import 'package:surfgear_webpage/webpage/menu/menu_button_widget.dart';
import 'package:surfgear_webpage/webpage/menu/menu_top_line_widget.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Верхнее меню
/// В зависимости от ширины экрана отрисовывает кнопку, либо верхнее меню
///https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class MenuTopWidget extends StatelessWidget {
  final AnimationController _animationController;
  final Function _onMenuTap;

  MenuTopWidget(
    this._animationController,
    this._onMenuTap,
  );

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // если ширина экрана <= минимальной ширины
    if (screenWidth > 0 && screenWidth <= SMALL_SCREEN_WIDTH) {
      // отрисовать кнопку меню
      return MenuButton(
        menuButtonAnimationController: _animationController,
        onMenuTap: _onMenuTap,
      );
    } else {
      // иначе отрисовать меню в виде верхней линии
      return MenuTopLineWidget();
    }
  }
}
