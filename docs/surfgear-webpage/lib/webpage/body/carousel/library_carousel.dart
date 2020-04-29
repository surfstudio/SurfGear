import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/webpage/common/animated_title.dart';
import 'package:surfgear_webpage/webpage/common/offset_animated_widget.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Карусель библиотек
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=3%3A0
class Carousel extends StatefulWidget {
  final List<Widget> items;
  final double screenWidth;
  final double scrollOffset;

  Carousel(
    this.scrollOffset,
    this.screenWidth,
    this.items,
  );

  @override
  State<StatefulWidget> createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  /// Контроллер для первой карусели
  PageController _firstPageController;

  /// Контроллер для второй карусели
  PageController _secondPageController;

  /// Итемы для первой карусели
  List<Widget> itemsForFirstCarousel;

  /// Итемы для второй карусели
  List<Widget> itemsForSecondCarousel;

  /// Включение анимации у второго контроллера
  /// необходимо чтобы несколько раз не включать анимацию
  /// когда ширина экрана >= [MEDIUM_SCREEN_WIDTH]
  bool _isSecondPageControllerAnimate = false;

  /// Триггер, по которому стартует анимация появления карусели
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    _initPageControllers();
  }

  /// Инициализация PageController'ов
  void _initPageControllers() async {
    final viewportFraction = 0.4;
    _firstPageController = new PageController(
      viewportFraction: viewportFraction,
    );
    _secondPageController = new PageController(
      viewportFraction: viewportFraction,
    );

    _animatePageController(_firstPageController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CarouselTitle(widget.scrollOffset),
        IgnorePointer(
          ignoring: true,
          child: ScrollOffsetWidget(
            scrollOffset: widget.scrollOffset,
            hasScrolled: () {
              _startAnimation = true;
            },
            child: AnimatedOpacity(
              opacity: _startAnimation ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Container(
                height: widget.screenWidth >= SMALL_SCREEN_WIDTH ? 610 : 305,
                child: _buildCarousel(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Логика отрисовки карусели
  Widget _buildCarousel() {
    if (widget.screenWidth <= SMALL_SCREEN_WIDTH) {
      _isSecondPageControllerAnimate = false;
      return _buildSingleCarousel(
        widget.items,
        _firstPageController,
      );
    } else {
      // если контроллер небыл включен
      // необходимо включить анимацию второго контроллера
      if (!_isSecondPageControllerAnimate) {
        // перед тем как рисовать карусели
        // необходимо распределить по ним данные по половинкам
        _halveAnItems();
        _animatePageController(_secondPageController);
      }

      _isSecondPageControllerAnimate = true;
      return _buildTwoCarousels();
    }
  }

  /// отрисовать одиночную карусель
  ///
  /// items - итемы библиотек
  /// controller - контроллер PageView
  /// isReverse - направление скролла
  Widget _buildSingleCarousel(
    List<Widget> items,
    PageController controller, {
    bool isReverse = false,
  }) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: controller,
      reverse: isReverse,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var padding = 0.0;
        if (widget.screenWidth <= SMALL_SCREEN_WIDTH) {
          padding = 16.0;
        }
        return Padding(
          padding: EdgeInsets.only(
            left: padding,
            right: padding,
          ),
          child: items[_getNextIndex(index, items)],
        );
      },
    );
  }

  /// Отрисовать две карусели
  Widget _buildTwoCarousels() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildSingleCarousel(
            itemsForFirstCarousel,
            _firstPageController,
          ),
        ),
        SizedBox(height: 89),
        Expanded(
            flex: 1,
            child: _buildSingleCarousel(
              itemsForSecondCarousel,
              _secondPageController,
              isReverse: true,
            )),
      ],
    );
  }

  /// Анимация PageController
  /// TODO надо изучить как можно выгрузить логику анимации в отдельный поток
  /// TODO т.к while(true) сильно нагружает основной опток
  void _animatePageController(PageController controller) {
    Future.delayed(Duration(milliseconds: 10), () async {
      while (true) {
        await controller.nextPage(
          duration: Duration(seconds: 5),
          curve: Curves.linear,
        );
      }
    });
  }

  /// Располовинить массив данных
  /// для первой карусели - первая половина
  /// для второй карсесели - вторая половина
  void _halveAnItems() {
    if (widget.screenWidth >= SMALL_SCREEN_WIDTH) {
      setState(() {
        itemsForFirstCarousel =
            widget.items.sublist(0, widget.items.length ~/ 2);
        itemsForSecondCarousel =
            widget.items.sublist(widget.items.length ~/ 2, widget.items.length);
      });
    }
  }

  /// Получить индекс когда повторять итемы
  int _getRepeatIndex(int index, List<Widget> items) =>
      items.length * ((index / items.length).floor());

  /// Получить индекс следующего итема после окончания текущей итерации
  int _getNextIndex(int index, List<Widget> items) =>
      index > items.length - 1 ? index - _getRepeatIndex(index, items) : index;
}

/// Заголовок тела страницы
class _CarouselTitle extends StatefulWidget {
  final double scrollOffset;

  _CarouselTitle(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return _CarouselTitleState();
  }
}

/// Заголовок карусели
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class _CarouselTitleState extends State<_CarouselTitle> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= SMALL_SCREEN_WIDTH) {
      return _buildSmallTitle();
    } else {
      return _buildMediumAndBigTitle();
    }
  }

  /// Отрисовать средний и большой тайтл
  Widget _buildMediumAndBigTitle() {
    return Column(
      children: <Widget>[
        SizedBox(height: 120),
        AnimatedTitle(
          bodyTitleText,
          rubikBlackNormal38,
          Duration(milliseconds: 250),
          widget.scrollOffset,
        ),
        SizedBox(height: 28),
        AnimatedTitle(
          bodySubtitleText,
          rubikBlack300_38,
          Duration(milliseconds: 250),
          widget.scrollOffset,
        ),
        SizedBox(height: 100),
      ],
    );
  }

  /// Отрисовать маленький тайтл
  Widget _buildSmallTitle() {
    return Column(
      children: <Widget>[
        SizedBox(height: 60),
        AnimatedTitle(
          bodyTitleText,
          rubikBlackNormal28,
          Duration(milliseconds: 250),
          widget.scrollOffset,
        ),
        SizedBox(height: 20),
        AnimatedTitle(
          bodySubtitleText,
          rubikBlack300_28,
          Duration(milliseconds: 250),
          widget.scrollOffset,
        ),
        SizedBox(height: 68),
      ],
    );
  }
}

