import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/webpage/body/body_widget.dart';
import 'package:surfgear_webpage/webpage/footer/footer_widget.dart';
import 'package:surfgear_webpage/webpage/header/header_widget.dart';

/// Ширина среднего экрана
const double MEDIUM_SCREEN_WIDTH = 1500;

/// Ширина маленького экрана
const double SMALL_SCREEN_WIDTH = 800;

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
  /// Stream для хранения положения скролла страницы
  StreamController _pageOffsetController = StreamController<double>();

  /// ScrollController страницы
  ScrollController _pageScrollController;

  @override
  void initState() {
    super.initState();
    _initScrollControllerListener();
  }

  /// Инициализация ScrollController'а
  void _initScrollControllerListener() {
    _pageScrollController = ScrollController()
      ..addListener(
        () {
          var scrollOffset = _pageScrollController.offset;
          _pageOffsetController.add(scrollOffset);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _pageScrollController,
        child: Stack(
          children: [
            _buildSurfLogo(),
            Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.height,
                  ),
                  child: HeaderWidget(),
                ),
                StreamBuilder(
                  stream: _pageOffsetController.stream,
                  initialData: 0.0,
                  builder: (context, offset) {
                    return BodyWidget(offset.data);
                  },
                ),
                FooterWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Отрисовка логотипа тела страницы
  Widget _buildSurfLogo() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 3000,
      ),
      child: OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment(0, -0.35),
        child: Image.asset(
          imgBackgroundLogo,
          fit: BoxFit.fitWidth,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
