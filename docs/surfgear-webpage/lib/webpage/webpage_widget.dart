import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  StreamController _scrollOffsetController = StreamController<double>();

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initScrollControllerListener();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: HeaderWidget(),
            ),
            BodyWidget(),
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}
