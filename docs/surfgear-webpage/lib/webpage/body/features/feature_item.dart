import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Виджет фичи
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=14%3A2782
class FeatureItem extends StatefulWidget {
  /// Путь до картинки
  final String imagePath;

  /// Заголовок
  final String title;

  /// Описания
  final String description;

  /// Картинка слева или справа
  final bool isRightSide;

  /// Задержка анимации
  final Duration delay;

  /// Стрим, в котором хранится событие начала анимации
  StreamController<bool> controller;

  FeatureItem({
    @required this.imagePath,
    @required this.title,
    @required this.description,
    @required this.delay,
    this.isRightSide = false,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return _FeatureItem();
  }
}

class _FeatureItem extends State<FeatureItem>
    with SingleTickerProviderStateMixin {
  /// Начать анимацию
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    _listenStartAnimation();
  }

  void _listenStartAnimation() {
    widget.controller.stream.listen((event) async {
      if (!startAnimation) {
        await Future.delayed(widget.delay, () {
          setState(() {
            startAnimation = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      duration: Duration(milliseconds: 250),
      opacity: startAnimation ? 1.0 : 0.0,
      child: _buildFeatureItem(screenWidth),
    );
  }

  /// Отрисовать фичу
  Widget _buildFeatureItem(double screenWidth) {
    if (screenWidth <= SMALL_SCREEN_WIDTH) {
      return _buildSmallFeature();
    } else if (screenWidth > SMALL_SCREEN_WIDTH &&
        screenWidth <= MEDIUM_SCREEN_WIDTH) {
      return _buildMediumFeature(screenWidth);
    } else {
      return _buildBigFeature();
    }
  }

  /// Отрисовать большую фичу
  Widget _buildBigFeature() {
    return Column(
      children: <Widget>[
        Image.asset(widget.imagePath),
        SizedBox(height: 66),
        Text(
          widget.title,
          style: rubikBlackNormal36,
        ),
        SizedBox(height: 40),
        Container(
          width: 500,
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: rubikBlackNormal22,
          ),
        ),
      ],
    );
  }

  /// Отрисовать среднюю фичу
  Widget _buildMediumFeature(double screenWidth) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Spacer(),
        if (!widget.isRightSide) Image.asset(widget.imagePath),
        if (!widget.isRightSide) SizedBox(width: 50),
        Column(
          crossAxisAlignment: widget.isRightSide
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: rubikBlackNormal36,
            ),
            SizedBox(height: 20),
            Container(
              width: 600,
              child: Text(
                widget.description,
                textAlign: widget.isRightSide ? TextAlign.end : TextAlign.start,
                style: rubikBlackNormal22,
              ),
            ),
          ],
        ),
        if (widget.isRightSide) SizedBox(width: 80),
        if (widget.isRightSide) Image.asset(widget.imagePath),
        Spacer(),
      ],
    );
  }

  /// Отрисовать маленькую фичу
  Widget _buildSmallFeature() {
    return Column(
      children: <Widget>[
        Image.asset(widget.imagePath),
        SizedBox(height: 32.0),
        Text(
          widget.title,
          style: rubikBlack300_28,
        ),
        SizedBox(height: 19.0),
        Container(
          width: 500,
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: rubikBlackNormal22,
          ),
        ),
      ],
    );
  }
}
