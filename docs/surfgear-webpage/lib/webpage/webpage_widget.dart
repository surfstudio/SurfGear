import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/webpage/body/body_widget.dart';
import 'package:surfgear_webpage/webpage/footer/footer_widget.dart';
import 'package:surfgear_webpage/webpage/header/header_widget.dart';
import 'package:surfgear_webpage/webpage/menu/menu_screen_widget.dart';

/// Ширина широкого экрана
const double BIG_SCREEN_WIDTH = 1000;

/// Ширина среднего экрана
const double MEDIUM_SCREEN_WIDTH = 800;

/// Ширина маленького экрана
const double SMALL_SCREEN_WIDTH = 600;

/// Виджет вебстраницы
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=3%3A0
class WebpageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebpageWidgetState();
  }
}

class _WebpageWidgetState extends State<WebpageWidget>
    with SingleTickerProviderStateMixin {
  StreamController _scrollOffsetController = StreamController<double>();

  ScrollController _scrollController;
  AnimationController _menuButtonAnimationController;

  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _initScrollControllerListener();
    _initAnimationController();
  }

  void _initScrollControllerListener() {
    _scrollController = ScrollController()
      ..addListener(
        () {
          var scrollOffset = _scrollController.offset;
          _scrollOffsetController.add(scrollOffset);
        },
      );
  }

  void _initAnimationController() {
    _menuButtonAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: <Widget>[
              HeaderWidget(
                onMenuTap: _openMenuScreen,
                animationController: _menuButtonAnimationController,
              ),
              BodyWidget(),
              FooterWidget(),
            ],
          ),
          _buildMenuScreen(screenWidth),
        ],
      ),
    );
  }

  /// Отрисовка меню в виде экрана
  Widget _buildMenuScreen(double screenWidth) {
    // если ширина экрана > минимальной ширины
    if (screenWidth > SMALL_SCREEN_WIDTH) {
      // необходимо закрыть меню экрана
      _closeMenuScreen();
    }

    // если нажали на кнопку меню открыть экран меню
    if (_isMenuOpen) {
      return MenuScreenWidget(
        onMenuTap: _closeMenuScreen,
        menuButtonAnimationController: _menuButtonAnimationController,
      );
    } else {
      return SizedBox();
    }
  }

  /// закрыть экран меню
  void _closeMenuScreen() {
    setState(() {
      _isMenuOpen = false;
      _menuButtonAnimationController.reverse();
    });
  }

  /// открыть экран меню
  void _openMenuScreen() {
    setState(() {
      _isMenuOpen = true;
      _menuButtonAnimationController.forward();
    });
  }
}
