import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/common/animated_title.dart';
import 'package:surfgear_webpage/common/offset_animated_widget.dart';
import 'package:surfgear_webpage/pages/main/main_page.dart';

/// Library carousel
class Carousel extends StatefulWidget {
  /// Items for carousel
  final List<Widget> items;

  /// Screen width
  final double screenWidth;

  /// Scroll offset of page
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
  /// PageController for first carousel
  PageController _firstPageController;

  /// PageController for second carousel
  PageController _secondPageController;

  /// Items for first carousel
  List<Widget> itemsForFirstCarousel;

  /// Items for second carousel
  List<Widget> itemsForSecondCarousel;

  /// Enable animation for the second controller
  /// it is necessary not to include animation several times
  /// when screen width> = [MEDIUM_SCREEN_WIDTH]
  bool _isSecondPageControllerAnimate = false;

  /// The trigger that starts the carousel animation
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    _initPageControllers();
  }

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

  /// build single carousel
  ///
  /// items - items for carousel
  /// controller - PageController of carousel
  /// isReverse - scroll direction
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

  /// PageController animation
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

  /// Half the items list
  /// for the first carousel - the first half
  /// for the second carousel - the second half
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

  /// Get index when repeating items
  int _getRepeatIndex(int index, List<Widget> items) =>
      items.length * ((index / items.length).floor());

  /// Get the index of the next item after the end of the current iteration
  int _getNextIndex(int index, List<Widget> items) =>
      index > items.length - 1 ? index - _getRepeatIndex(index, items) : index;
}

/// Page body title
class _CarouselTitle extends StatefulWidget {
  final double scrollOffset;

  _CarouselTitle(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return _CarouselTitleState();
  }
}

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

  Widget _buildMediumAndBigTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 145.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 120),
          AnimatedTitle(
            mainPageBodyTitleText,
            headlineTextStyle(),
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 28),
          AnimatedTitle(
            mainPageBodySubtitleText,
            headlineTextStyle(fontWeight: FontWeight.w300),
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSmallTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 95.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 60),
          AnimatedTitle(
            mainPageBodyTitleText,
            headlineTextStyle(fontSize: 28.0),
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 20),
          AnimatedTitle(
            mainPageBodySubtitleText,
            headlineTextStyle(fontSize: 28.0, fontWeight: FontWeight.w300),
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 68),
        ],
      ),
    );
  }
}
